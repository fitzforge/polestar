-- Chinese (traditional) (zhTW): the guide forever/class/rogue/blade-of-cunning-alliance (forever/class/rogue/blade-of-cunning-alliance.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {item:7298} Blade of Cunning
	["{item:7298} (Alliance)"] = "{item:7298}（聯盟）",
	["A dagger at 10 from your home town's rogue quests."] = "10級時從家鄉盜賊任務獲得的匕首。",

	-- Step 1: Seek out SI: 7
	-- {npc:917} Keryn Sylvius · {npc:332} Master Mathias Shaw · {zone:1453} Stormwind
	["At 10 {npc:917}, the rogue trainer upstairs in the Lion's Pride Inn in Goldshire, gives you a package for {npc:332} in {zone:1453}. Train Pick Pocket if you lack it: this chain needs it."] = "",

	-- Step 2: Master Mathias Shaw
	-- {zone:1453} Stormwind · {object:2100} Old Town
	["Head north to {zone:1453}. Shaw stands upstairs in the SI:7 building in {object:2100} (the quest says the Barracks; it means SI:7)."] = "",

	-- Step 3: Defias Dockmaster
	-- {npc:6846} Defias Dockmaster
	["The {npc:6846} (level 10, a goblin) works in the dock house at Jerod's Landing, on the river at Elwynn's southern edge, south of Goldshire. Stealth in and Pick Pocket him from behind: the schedule never drops from his corpse. Do not open with Sap or a fight: he calls in three waves of bodyguards. Keep away from the fireplaces in the house; they burn you out of stealth. He is back 2 to 5 minutes after a death."] = "",
	-- {npc:6846} Defias Dockmaster · {item:7675} Defias Shipping Schedule
	["Pick Pocket the {npc:6846} for the {item:7675}"] = "",

	-- Step 4: Back to Mathias Shaw
	["Back to Mathias Shaw"] = "回到馬迪亞斯·肖爾那裡",
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, SI:7"] = "{npc:332}，軍情七處",

	-- Step 5: Road to Salvation
	-- {npc:1234} Hogral Bakkan · {npc:5165} Hulfdan Blackbeard · {zone:1455} Ironforge
	["At 10 {npc:1234}, the rogue trainer in the Thunderbrew Distillery in Kharanos, sends you to {npc:5165} in {zone:1455}."] = "",

	-- Step 6: Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard · {object:32383} Forlorn Cavern · {zone:1455} Ironforge
	["{npc:5165} is in the {object:32383}, the rogue quarter in the north of {zone:1455}: go into the building with a shady dealer outside and down the stairs."] = "",

	-- Step 7: Onin MacHammar
	-- {npc:6886} Onin MacHammar · {npc:1211} Leper Gnome
	["Head west to Gnomeregan. Beside the road to its entrance stands a wooden spiral tower: {npc:6886} waits stealthed on the top platform, next to a level 10 {npc:1211}, so you only see him up close."] = "",

	-- Step 8: Back to Hulfdan Blackbeard
	-- {npc:5165} Hulfdan Blackbeard
	["Back to {npc:5165}"] = "回到{npc:5165}那裡",

	-- Step 9: The Apple Falls
	-- {npc:3599} Jannok Breezesong · {npc:4163} Syurna · {zone:1457} Darnassus
	["At 10 {npc:3599}, the rogue trainer in the Dolanaar inn, gives you a rose for {npc:4163} in {zone:1457}. If you lose the rose, abandon the quest and take it again."] = "",

	-- Step 10: Syurna
	-- {zone:1457} Darnassus · {npc:4163} Syurna
	["Head west to {zone:1457}. {npc:4163} is below ground in the Cenarion Enclave: the way down is the opening at the foot of the split tree left of the Arch Druid's tree, near the nightsaber trainer. Her map marker shows above ground."] = "",

	-- Step 11: Sethir the Ancient
	-- {npc:6909} Sethir the Ancient · {object:12360} Oracle Glade (no name in this language: may be words)
	["{npc:6909} (level 12 satyr) lives out on a great branch north of the {object:12360}: go through the V-shaped gap in the wall north of the glade and out along the branch. Pick his pocket for the journal; killing him does not give it, and a fight brings out three Minions of Sethir. He walks between the main branch and a side branch: wait stealthed at the far end of the main branch and pick him from behind when he comes back. Then Sprint away. He is back 8 1/2 minutes after a death."] = "",
	-- {item:7737} Sethir's Journal
	["Pick Pocket Sethir the Ancient for {item:7737}"] = "",

	-- Step 12: Back to Syurna
	-- {npc:4163} Syurna
	["Back to {npc:4163}"] = "返回{npc:4163}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 10 {npc:1234}, the rogue trainer in the {area:2102} in {area:131}, sends you to {npc:5165} in {zone:1455}."] = "10級時，{area:131}{area:2102}的盜賊訓練師{npc:1234}會派你去找{zone:1455}的{npc:5165}。",
	-- ["At 10 {npc:3599}, the rogue trainer in {area:186}, gives you a rose for {npc:4163} in {zone:1457}."] = "10級時，{area:186}的盜賊訓練師{npc:3599}會給你一朵玫瑰，交給{zone:1457}的{npc:4163}。",
	-- ["At 10 {npc:917}, the rogue trainer in the Lion's Pride Inn in {area:87}, gives you a package for {npc:332} in {zone:1453}."] = "10級時，{area:87}旅店裡的盜賊訓練師{npc:917}會給你一個包裹，交給{zone:1453}的{npc:332}。",
	-- ["Ride north to {zone:1453}; Mathias Shaw is at SI:7 in {object:2100}."] = "向北騎往{zone:1453}；馬迪亞斯·肖爾在{object:2100}的軍情七處。",
	-- ["Ride west to {zone:1457}. {npc:4163} stands in the north-west of the city."] = "向西騎往{zone:1457}。{npc:4163}站在城市西北部。",
	-- ["The {npc:6846} stands by the river at Elwynn's southern edge, south of {area:87}. He carries the shipping schedule."] = "{npc:6846}站在艾爾文森林南緣、{area:87}南邊的河邊。他身上帶著船運時間表。",
	-- ["{npc:5165} stands in the north of {zone:1455}."] = "{npc:5165}站在{zone:1455}北部。",
	-- ["{npc:6886} waits near {area:133}, in western {zone:1426}."] = "{npc:6886}在{zone:1426}西部的{area:133}附近等候。",
	-- ["{npc:6909} lives in the north of {zone:1438}, north-east of {zone:1457}. Take his journal."] = "{npc:6909}住在{zone:1438}北部、{zone:1457}東北方。拿走他的日記。",
}
