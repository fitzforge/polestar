-- Chinese (traditional) (zhTW): the guide forever/class/shaman/call-of-fire-alliance (forever/class/shaman/call-of-fire-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94449} Call of Fire
	["{quest:94449} (Alliance)"] = "{quest:94449}（聯盟）",
	-- {item:5176} Fire Totem · {spell:3599} Searing Totem · {item:263412} Totem of Charged Flames
	["Your {item:5176} for every fire totem, {spell:3599} with it, and Forever's {item:263412}."] = "獲得用於所有火焰圖騰的{item:5176}、藉此學會的{spell:3599}，以及Forever的{item:263412}。",

	-- Step 1: Call of Fire
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge · {npc:257597} Bruegs Kindleborn
	["At 10 {npc:258113}, the shaman trainer in {area:131}, or {npc:258098}, the shaman trainer in {zone:1455}, sends you to {npc:257597}."] = "10級時，{area:131}的薩滿訓練師{npc:258113}，或{zone:1455}的薩滿訓練師{npc:258098}，會派你去找{npc:257597}。",
	-- {npc:258113} Ingrid Dunwald · {area:131} Kharanos · {npc:258098} Eldrun Stormbreaker · {zone:1455} Ironforge
	["{npc:258113}, {area:131}; or {npc:258098}, {zone:1455}"] = "{npc:258113}，{area:131}；或{npc:258098}，{zone:1455}",

	-- Step 2: Bruegs Kindleborn
	-- {area:806} South Gate Outpost · {npc:1959} Mountaineer Barleybrew · {npc:257597} Bruegs Kindleborn · {item:6653} Torch of the Dormant Flame
	["Follow the road east to the tunnel towards {area:806}. Out of the first tunnel, keep left past {npc:1959} and the tower: a slim trail, hard to see but shown on the minimap, winds up the mountain to {npc:257597}' cave above the farm. He hands you the {item:6653}: keep it until the end of the chain."] = "沿路向東到通往{area:806}的隧道。出第一個隧道後，靠左經過{npc:1959}和塔樓：一條細窄的小路雖然難看清，但小地圖上會顯示，它盤山而上通往農場上方的{npc:257597}洞穴。他給你{item:6653}：留到任務鏈結束。",

	-- Step 3: Braldir Ashmantle
	-- {npc:257597} Bruegs Kindleborn · {zone:1432} Loch Modan · {npc:257808} Braldir Ashmantle · {area:144} Thelsamar
	["From {npc:257597}' ledge you can drop carefully down the mountain into {zone:1432}, or walk back through the tunnel. {npc:257808} keeps the shrine on the peak just south of {area:144}: a hidden trail along a cliff ledge, marked by stone totems, climbs to it from the road north of the peak."] = "從{npc:257597}的巖架，你可以小心地從山上跳到{zone:1432}，或從隧道走回去。{npc:257808}守著{area:144}正南方山頂上的神龕：一條沿懸崖巖架、由石圖騰標記的隱秘小路，從山頂北邊的道路向上通往那裡。",

	-- Step 4: Reagent Pouch
	-- {area:923} Stonesplinter Valley · {area:144} Thelsamar · {spell:1245113} Lightning Bolts
	-- plural, as words: Stonesplinter Seers = {npc:1166} Stonesplinter Seer
	["The Stonesplinter Seers (level 13-14) stand among the troggs of {area:923} in the south of the loch, and in the trogg camps north-east of {area:144}. They throw {spell:1245113} from 40 yards and run for help when hurt: pull one at a time. Respawn about five minutes."] = "",

	-- Step 5: Fire Tar
	-- {area:149} Silver Stream Mine · {area:144} Thelsamar · {spell:2136} Fire Blast · {spell:134} Fire Shield
	-- plural, as words: Tunnel Rat Geomancers = {npc:1174} Tunnel Rat Geomancer
	["The Tunnel Rat Geomancers (level 12-13) work only inside the {area:149} at the north end of the loch, past {area:144}. They cast {spell:2136} behind a {spell:134} and run for help at low health."] = "隧道鼠地卜師（12-13級）只在湖泊北端、過了{area:144}之後的{area:149}內活動。他們會躲在{spell:134}後面施放{spell:2136}，低血量時跑去求援。",

	-- Step 6: Braldir Ashmantle
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta
	["Back up the trail to {npc:257808}. He makes the {item:6636} from the tar and the pouch: keep it with the torch."] = "沿小路返回{npc:257808}處。他用焦油和袋子製作{item:6636}：把它和火把一起留著。",

	-- Step 7: Lost the Fire Sapta?
	-- {quest:94473} Fire Sapta
	["Lost the {quest:94473}?"] = "弄丟了{quest:94473}？",
	-- {quest:94473} Fire Sapta · {npc:257808} Braldir Ashmantle
	["Only if the {quest:94473} is gone from your bags: {npc:257808} gives you another."] = "只有在{quest:94473}從你的包裡消失時：{npc:257808}會再給你一個。",
	-- {npc:257808} Braldir Ashmantle · {quest:94473} Fire Sapta
	["{npc:257808}: a new {quest:94473}"] = "{npc:257808}：新的{quest:94473}",

	-- Step 8: The Shrine of Eternal Flame
	["The Shrine of Eternal Flame"] = "永恆之焰神龕",
	-- {npc:257808} Braldir Ashmantle · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {spell:8017} Rockbiter Weapon · {spell:8042} Earth Shock · {item:6655} Glowing Ember
	["Climb on past {npc:257808} to the peak. Drink the {item:6636} beside the rock statue there to see the {npc:5893} (level 12): it waits until you strike, but grows stronger the longer it is left, and it is immune to fire. Open at once with {spell:8017} and {spell:8042}. Its {item:6655} drops every time."] = "經過{npc:257808}繼續爬到山頂。在巖石雕像旁喝下{item:6636}，就能看到{npc:5893}（12級）：它會一直等你出手，但放置越久就越強，而且免疫火焰。立刻用{spell:8017}和{spell:8042}起手。它每次都會掉落{item:6655}。",
	-- {item:6636} Fire Sapta
	["{item:6636}, beside the statue"] = "{item:6636}，雕像旁",

	-- Step 9: The Brazier of the Dormant Flame
	-- {object:61934} Brazier of the Dormant Flame
	["The {object:61934}"] = "{object:61934}",
	-- {object:61934} Brazier of the Dormant Flame · {item:277329} Torch of Eternal Flame
	["Click the {object:61934} atop the shrine with the torch in your bags to place the ember, then click it again for the next quest: the lit {item:277329}."] = "揹包裡帶著火把，點選神龕頂部的{object:61934}放置餘燼，然後再點選它接取下一個任務：點燃的{item:277329}。",

	-- Step 10: Bruegs Kindleborn
	-- {npc:257597} Bruegs Kindleborn · {item:5176} Fire Totem
	["Back through the South Gate tunnel and up the trail to {npc:257597}' cave. Keep the {item:5176} in your bags for good: every fire totem needs it."] = "穿過南門隧道返回，沿小路向上到{npc:257597}的洞穴。把{item:5176}永久留在揹包裡：每個火焰圖騰都需要它。",
	-- {npc:257597} Bruegs Kindleborn · {spell:3599} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:257597}: {spell:3599}, your {item:5176} and the {item:263412}"] = "{npc:257597}：{spell:3599}、你的{item:5176}和{item:263412}",
}
