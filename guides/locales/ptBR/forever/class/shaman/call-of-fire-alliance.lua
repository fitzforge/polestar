-- Portuguese (Brazil) (ptBR): the guide forever/class/shaman/call-of-fire-alliance (forever/class/shaman/call-of-fire-alliance.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94449} Call of Fire
	["{quest:94449} (Alliance)"] = "{quest:94449} (Aliança)",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "Seu {item:5176} para todo totem de fogo, {spell:3599} junto com ele, e {item:263412} do Forever.",

	-- Step 1: Call of Fire
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:257597} Bruegs Kindleborn
	["At 10 {npc:258113}, the shaman trainer in {area:131}, or {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:257597}."] = "No nível 10, {npc:258113}, o instrutor de xamã em {area:131}, ou {npc:258098}, o instrutor de xamã em {zone:1455}, manda você para {npc:257597}.",
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge
	["{npc:258113}, {area:131}; or {npc:258098}, {zone:1455}"] = "{npc:258113}, {area:131}; ou {npc:258098}, {zone:1455}",

	-- Step 2: Bruegs Kindleborn
	-- {area:806} South Gate Outpost · {npc:1959} Mountaineer Barleybrew · {npc:257597} Bruegs Kindleborn · {item:6653} Torch of the Dormant Flame
	["Follow the road east to the tunnel towards {area:806}. Out of the first tunnel, keep left past {npc:1959} and the tower: a slim trail, hard to see but shown on the minimap, winds up the mountain to {npc:257597}' cave above the farm. He hands you the {item:6653}: keep it until the end of the chain."] = "Siga a estrada para leste até o túnel rumo a {area:806}. Ao sair do primeiro túnel, mantenha-se à esquerda, passando {npc:1959} e a torre: uma trilha estreita, difícil de ver mas marcada no minimapa, sobe a montanha até a caverna de {npc:257597}, acima da fazenda. Ele entrega {item:6653} a você: guarde até o fim da cadeia.",

	-- Step 3: Braldir Ashmantle
	-- {npc:257597} Bruegs Kindleborn · {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle · {area:144} Thelsamar
	["From {npc:257597}' ledge you can drop carefully down the mountain into {zone:1432}, or walk back through the tunnel. {npc:257808} keeps the shrine on the peak just south of {area:144}: a hidden trail along a cliff ledge, marked by stone totems, climbs to it from the road north of the peak."] = "Da saliência de {npc:257597}, você pode descer com cuidado a montanha até {zone:1432}, ou voltar a pé pelo túnel. {npc:257808} cuida do santuário no pico logo ao sul de {area:144}: uma trilha escondida por uma saliência do penhasco, marcada por totens de pedra, sobe até ele a partir da estrada ao norte do pico.",

	-- Step 4: Reagent Pouch
	-- {area:923} Stonesplinter Valley · {area:144} Thelsamar · {spell:1245113} Lightning Bolts
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["The Stonesplinter Seers (level 13-14) stand among the troggs of {area:923} in the south of the loch, and in the trogg camps north-east of {area:144}. They throw {spell:1245113} from 40 yards and run for help when hurt: pull one at a time. Respawn about five minutes."] = "Os Videntes Lascapedra (nível 13-14) ficam entre os trogues de {area:923}, no sul do lago, e nos acampamentos de trogues a nordeste de {area:144}. Eles jogam {spell:1245113} a 40 metros e correm atrás de ajuda quando feridos: puxe um de cada vez. Voltam em cerca de cinco minutos.",

	-- Step 5: Fire Tar
	-- {area:149} Silver Stream Mine · {area:144} Thelsamar · {spell:2136} Fire Blast · {spell:134} Fire Shield
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["The Tunnel Rat Geomancers (level 12-13) work only inside the {area:149} at the north end of the loch, past {area:144}. They cast {spell:2136} behind a {spell:134} and run for help at low health."] = "Os Geomantes Ratatúnel (nível 12-13) trabalham só dentro de {area:149}, no extremo norte do lago, depois de {area:144}. Eles lançam {spell:2136} atrás de {spell:134} e correm atrás de ajuda com pouca vida.",

	-- Step 6: Braldir Ashmantle
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta
	["Back up the trail to {npc:257808}. He makes the {item:6636} from the tar and the pouch: keep it with the torch."] = "De volta pela trilha até {npc:257808}. Ele faz {item:6636} com o piche e a bolsinha: guarde junto com a tocha.",

	-- Step 7: Lost the Fire Sapta?
	-- {quest:94473} Fire Sapta
	["Lost the {quest:94473}?"] = "Perdeu {quest:94473}?",
	-- {quest:94473} Fire Sapta · {npc:257808} Braldir Ashmantle
	["Only if the {quest:94473} is gone from your bags: {npc:257808} gives you another."] = "Só se {quest:94473} sumiu das suas bolsas: {npc:257808} entrega outra.",
	-- {npc:257808} Braldir Ashmantle · {quest:94473} Fire Sapta
	["{npc:257808}: a new {quest:94473}"] = "{npc:257808}: uma nova {quest:94473}",

	-- Step 8: The Shrine of Eternal Flame
	["The Shrine of Eternal Flame"] = "O Santuário da Chama Eterna",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Climb on past {npc:257808} to the peak. Drink the {item:6636} beside the rock statue there to see the {npc:5893} (level 12): it waits until you strike, but grows stronger the longer it is left, and it is immune to fire. Open at once with {spell:8017} and {spell:8042}. Its {item:6655} drops every time."] = "Suba além de {npc:257808}, até o pico. Beba {item:6636} ao lado da estátua de pedra para ver {npc:5893} (nível 12): ela espera até você atacar, mas fica mais forte quanto mais tempo é deixada, e é imune a fogo. Abra de imediato com {spell:8017} e {spell:8042}. {item:6655} dela cai sempre.",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the statue"] = "{item:6636}, ao lado da estátua",

	-- Step 9: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} atop the shrine with the torch in your bags to place the ember, then click it again for the next quest: the lit {item:277329}."] = "Clique em {object:61934}, no alto do santuário, com a tocha nas suas bolsas, para colocar a brasa, e depois clique de novo para a próxima missão: {item:277329} acesa.",

	-- Step 10: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {item:5176} Fire Totem
	["Back through the South Gate tunnel and up the trail to {npc:257597}' cave. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "De volta pelo túnel do Portão Sul e subindo a trilha até a caverna de {npc:257597}. Guarde {item:5176} nas suas bolsas para sempre: todo totem de fogo precisa dele.",
	-- {npc:257597} Bruegs Kindleborn · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:257597}: {spell:3599}, seu {item:5176} e {item:263412}",
}
