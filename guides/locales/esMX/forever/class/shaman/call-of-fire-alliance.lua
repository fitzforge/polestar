-- Spanish (Latin America) (esMX): the guide forever/class/shaman/call-of-fire-alliance (forever/class/shaman/call-of-fire-alliance.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94449} Call of Fire
	["{quest:94449} (Alliance)"] = "{quest:94449} (Alianza)",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "Tu {item:5176} para todo tótem de fuego, {spell:3599} con él, y {item:263412} de Forever.",

	-- Step 1: Call of Fire
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:257597} Bruegs Kindleborn
	["At 10 {npc:258113}, the shaman trainer in {area:131}, or {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:257597}."] = "A nivel 10, {npc:258113}, la instructora de chamanes en {area:131}, o {npc:258098}, el instructor de chamanes en {zone:1455}, te manda con {npc:257597}.",
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge
	["{npc:258113}, {area:131}; or {npc:258098}, {zone:1455}"] = "{npc:258113}, {area:131}; o {npc:258098}, {zone:1455}",

	-- Step 2: Bruegs Kindleborn
	-- {area:806} South Gate Outpost · {npc:1959} Mountaineer Barleybrew · {npc:257597} Bruegs Kindleborn · {item:6653} Torch of the Dormant Flame
	["Follow the road east to the tunnel towards {area:806}. Out of the first tunnel, keep left past {npc:1959} and the tower: a slim trail, hard to see but shown on the minimap, winds up the mountain to {npc:257597}' cave above the farm. He hands you the {item:6653}: keep it until the end of the chain."] = "Sigue el camino al este hasta el túnel hacia {area:806}. Al salir del primer túnel, mantente a la izquierda pasando a {npc:1959} y la torre: un sendero angosto, difícil de ver pero que aparece en el minimapa, sube serpenteando por la montaña hasta la cueva de {npc:257597}, sobre la granja. Te da {item:6653}: guárdala hasta el final de la cadena.",

	-- Step 3: Braldir Ashmantle
	-- {npc:257597} Bruegs Kindleborn · {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle · {area:144} Thelsamar
	["From {npc:257597}' ledge you can drop carefully down the mountain into {zone:1432}, or walk back through the tunnel. {npc:257808} keeps the shrine on the peak just south of {area:144}: a hidden trail along a cliff ledge, marked by stone totems, climbs to it from the road north of the peak."] = "Desde la cornisa de {npc:257597} puedes bajar con cuidado por la montaña hasta {zone:1432}, o volver por el túnel. {npc:257808} cuida el santuario en la cima justo al sur de {area:144}: un sendero oculto por una cornisa del acantilado, marcado con tótems de piedra, sube hasta él desde el camino al norte de la cima.",

	-- Step 4: Reagent Pouch
	-- {area:923} Stonesplinter Valley · {area:144} Thelsamar · {spell:1245113} Lightning Bolts
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["The Stonesplinter Seers (level 13-14) stand among the troggs of {area:923} in the south of the loch, and in the trogg camps north-east of {area:144}. They throw {spell:1245113} from 40 yards and run for help when hurt: pull one at a time. Respawn about five minutes."] = "Los videntes Rompepiedras (nivel 13-14) están entre los troggs de {area:923}, en el sur del lago, y en los campamentos de troggs al noreste de {area:144}. Lanzan {spell:1245113} desde 40 m y huyen a pedir ayuda cuando están heridos: atráelos de a uno. Reaparecen en unos cinco minutos.",

	-- Step 5: Fire Tar
	-- {area:149} Silver Stream Mine · {area:144} Thelsamar · {spell:2136} Fire Blast · {spell:134} Fire Shield
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["The Tunnel Rat Geomancers (level 12-13) work only inside the {area:149} at the north end of the loch, past {area:144}. They cast {spell:2136} behind a {spell:134} and run for help at low health."] = "Los geomantes rata de túnel (nivel 12-13) trabajan solo dentro de {area:149}, en el extremo norte del lago, pasando {area:144}. Lanzan {spell:2136} detrás de un {spell:134} y huyen a pedir ayuda con poca salud.",

	-- Step 6: Braldir Ashmantle
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta
	["Back up the trail to {npc:257808}. He makes the {item:6636} from the tar and the pouch: keep it with the torch."] = "Vuelve a subir por el sendero hasta {npc:257808}. Prepara {item:6636} con el alquitrán y la bolsa: guárdalo con la antorcha.",

	-- Step 7: Lost the Fire Sapta?
	-- {quest:94473} Fire Sapta
	["Lost the {quest:94473}?"] = "¿Perdiste {quest:94473}?",
	-- {quest:94473} Fire Sapta · {npc:257808} Braldir Ashmantle
	["Only if the {quest:94473} is gone from your bags: {npc:257808} gives you another."] = "Solo si {quest:94473} ya no está en tus bolsas: {npc:257808} te da otro.",
	-- {npc:257808} Braldir Ashmantle · {quest:94473} Fire Sapta
	["{npc:257808}: a new {quest:94473}"] = "{npc:257808}: un {quest:94473} nuevo",

	-- Step 8: The Shrine of Eternal Flame
	["The Shrine of Eternal Flame"] = "El Santuario de la Llama Eterna",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Climb on past {npc:257808} to the peak. Drink the {item:6636} beside the rock statue there to see the {npc:5893} (level 12): it waits until you strike, but grows stronger the longer it is left, and it is immune to fire. Open at once with {spell:8017} and {spell:8042}. Its {item:6655} drops every time."] = "Sigue subiendo pasando a {npc:257808} hasta la cima. Bebe {item:6636} junto a la estatua de roca de ahí para ver a la {npc:5893} (nivel 12): espera a que ataques, pero se vuelve más fuerte cuanto más tiempo la dejas, y es inmune al fuego. Empieza enseguida con {spell:8017} y {spell:8042}. Su {item:6655} cae siempre.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the statue"] = "{item:6636}, junto a la estatua",

	-- Step 9: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} atop the shrine with the torch in your bags to place the ember, then click it again for the next quest: the lit {item:277329}."] = "Haz clic en {object:61934}, en lo alto del santuario, con la antorcha en tus bolsas para colocar la brasa, y luego vuelve a hacer clic para la siguiente misión: {item:277329} encendida.",

	-- Step 10: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {item:5176} Fire Totem
	["Back through the South Gate tunnel and up the trail to {npc:257597}' cave. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "De vuelta por el túnel de la Puerta Sur y sube por el sendero hasta la cueva de {npc:257597}. Guarda {item:5176} en tus bolsas para siempre: todo tótem de fuego lo necesita.",
	-- {npc:257597} Bruegs Kindleborn · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {spell:3599}, tu {item:5176} y {item:263412}",
}
