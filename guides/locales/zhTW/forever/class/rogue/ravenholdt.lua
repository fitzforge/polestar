-- Chinese (traditional) (zhTW): the guide forever/class/rogue/ravenholdt (forever/class/rogue/ravenholdt.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:3486} Ravenholdt Manor · {npc:13085} Myrokos Silentform
	["Opens {area:3486}, the hidden rogue house in the Alterac hills, and {npc:13085}'s jobs against the Syndicate."] = "",
	-- {npc:13936} Ravenholdt
	["{npc:13936} reputation"] = "{npc:13936}聲望",

	-- Step 1: The Elegant Letter
	-- {item:17126} Elegant Letter
	["The {item:17126}"] = "{item:17126}",
	-- {npc:332} Master Mathias Shaw · {npc:918} Osborne the Night Man · {zone:1453} Stormwind · {zone:1454} Orgrimmar · {item:17126} Elegant Letter · {npc:13936} Ravenholdt · {item:17125} Seal of Ravenholdt · {npc:6707} Fahrad · {spell:1846} Detect Traps
	["At 24 any capital's rogue trainer ({npc:332} or {npc:918} in {zone:1453}, Gest or Ormok in {zone:1454}, and the others) has an {item:17126} from {npc:13936} for you: ask for it in their talk window. Open it: the quest gives you the {item:17125} for {npc:6707}. Learn {spell:1846} from your trainer first if you have not; the way in is a test of it."] = "",

	-- Step 2: Ravenholdt Manor
	-- {area:272} Tarren Mill · {area:271} Southshore · {area:275} Durnholde Keep · {spell:1846} Detect Traps · {area:3486} Ravenholdt Manor · {npc:6707} Fahrad · {npc:13936} Ravenholdt
	["Horde fly to {area:272}, Alliance to {area:271}. The trail to the manor is hard to see: it starts behind the plateau north of {area:275}, east of {area:272}, climbs into the hills and bends twice to a small tunnel. A chest sits in the tunnel: do not open it. Cast {spell:1846} near it and walk up close; that is the Rite of Cunning (it comes back after 5 minutes). Opening the chest calls Milton, an elite rogue of about level 32. Through the tunnel lies {area:3486}: {npc:6707} is upstairs inside. Do not attack anyone at the manor: it costs {npc:13936} reputation."] = "",
	-- {spell:1846} Detect Traps
	["Rite of Cunning: {spell:1846} beside the tunnel chest"] = "",
	-- {npc:6766} Ravenholdt Guard · {quest:6701} Syndicate Emblems
	["{npc:6766}: {quest:6701}, repeatable; take it now, the emblems are quest items"] = "",

	-- Step 3: Lord Tomas
	-- {npc:266216} Lord Tomas · {area:275} Durnholde Keep · {npc:13085} Myrokos Silentform · {quest:6701} Syndicate Emblems
	-- plural, as words: Syndicate Rogues = {npc:2260} Syndicate Rogue
	["{npc:266216} is inside {area:275}, the Syndicate fortress south of the manor; he can stand in any of fifteen spots in the keep, so search. Quick and quiet, says {npc:13085}. Pick the pockets of the level 20-21 Syndicate Rogues, Shadow Mages and Watchmen on your way: they carry {quest:6701} for the guards' repeatable reputation quest."] = "",
	-- {quest:6701} Syndicate Emblems
	["Pick Pocket Syndicate members for {quest:6701}"] = "",

	-- Step 4: Myrokos Silentform
	-- {npc:6766} Ravenholdt Guard
	["{npc:6766}: one emblem each time, 100 reputation"] = "",

	-- Step 5: What's the Big Idea?
	-- {npc:13085} Myrokos Silentform · {area:280} Strahnbrad · {zone:1416} Alterac Mountains · {spell:921} Pick Pocket
	["In your mid 30s {npc:13085} has two more jobs; take both. Barton leads a Syndicate scouting party at {area:280}, in the east of the {zone:1416}, inside one of the houses with stealthed Syndicate around him. Pick his pocket for the report and do not kill him: he does not drop it. If you are lower than him he sees through stealth; Master of Deception helps, or Distract him, Vanish and come in from behind. {spell:921} can miss several times in a row."] = "",
	-- {item:275482} Barton's Scouting Report
	["Pick Pocket Barton for {item:275482}"] = "",

	-- Step 6: Covert Extraction
	-- {npc:13085} Myrokos Silentform · {area:281} Ruins of Alterac · {zone:1416} Alterac Mountains
	["Back to {npc:13085}; the report sends you after the Perenolde heirlooms. Two towers stand among the {area:281}, in the middle of the {zone:1416}, held by ogres: the shield lies in the northern tower, the sword in the southern one, which elite ogres ring and watch from far off. Stay stealthed; nothing guards the heirlooms inside."] = "",
	-- {item:275636} Royal Aegis of Perenolde
	["{item:275636}, in the northern tower"] = "",
	-- {item:275635} Blade of House Perenolde
	["{item:275635}, in the southern tower"] = "",

	-- Step 7: A Way In
	-- {area:324} Stromgarde Keep · {area:313} Northfold Manor · {object:656157} Syndicate Footlocker (no name in this language: may be words) · {quest:96783} A Way In
	["{area:324} in western Arathi is a Syndicate stronghold; to get in you need a uniform. {area:313}, in north-western Arathi, is held by Syndicate Highwaymen, Pathstalkers and Mercenaries (level 30-32): find the {object:656157} there and take the uniform; that ends {quest:96783}."] = "",
	-- {quest:96784} Master of Disguise · {item:275706} Syndicate Uniform
	["{quest:96784}: the {item:275706}"] = "",

	-- Step 8: Anastasia Miller
	-- {item:275706} Syndicate Uniform · {quest:96784} Master of Disguise · {quest:96785} Ain't No Telling · {npc:266847} Anastasia Miller
	-- plural, as words: Syndicate Prowlers = {npc:2588} Syndicate Prowler
	["Stromgarde's Syndicate Prowlers and Conjurors are elite (level 35-36): a rogue of 36 can slip past them, but fighting one alone is hard, so stay hidden or bring a friend. Put on the {item:275706} ({quest:96784} hands it to you at the footlocker) to pass as one of them; stealth or suspicious acts can break it. If the footlocker gave you no uniform, Anastasia hands you one with {quest:96785}. {npc:266847} is not inside the keep: she stands on a ledge on the outside of the castle wall. Jump across to it from the roof of the house beside the ledge."] = "",

	-- Step 9: Ain't No Telling
	-- {item:275709} Stolen Funds
	["She will not talk without something to bargain with. Her stash is upstairs in a house close to the keep: take the {item:275709}. If it is already open, wait for it to come back."] = "",
	-- {item:275709} Stolen Funds
	["{item:275709}: Anastasia's Stash"] = "",

	-- Step 10: The Syndicate Sting
	-- {area:1057} Thoradin's Wall · {area:287} Hillsbrad · {item:275882} Intercepted Shipment · {item:275706} Syndicate Uniform · {npc:13085} Myrokos Silentform
	["Falconcrest's men make the handoff at the southern end of {area:1057}, the old wall between Arathi and {area:287}. Kill the two guarding the box and take the {item:275882}. Keep the {item:275706}: {npc:13085} wants it back with the shipment."] = "",

	-- Step 11: Back to Myrokos Silentform
	-- {npc:13085} Myrokos Silentform
	["Back to {npc:13085}"] = "返回{npc:13085}",
	-- {npc:13085} Myrokos Silentform · {npc:13936} Ravenholdt
	["{npc:13085}: 70 silver, 300 {npc:13936} reputation"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 24 an {item:17126} from {npc:13936} starts this; the data gives it to you through {npc:332} or {npc:918} in {zone:1453}, or Gest or Ormok in {zone:1454}. The quest hands you the {item:17125} for {npc:6707}."] = "24級時，{npc:13936}的{item:17126}會開啟此任務；依資料，你會透過{zone:1453}的{npc:332}或{npc:918}，或{zone:1454}的蓋斯特或奧莫克收到它。任務會給你{item:17125}，交給{npc:6707}。",
	-- ["At 36, {npc:13085} sends you after Barton's scouting report. Barton leads a Syndicate party at {area:280}, in the east of the {zone:1416}: pick his pocket, do not kill him."] = "36級時，{npc:13085}派你去取巴爾頓的偵察報告。巴爾頓率領一支辛迪加隊伍在{zone:1416}東部的{area:280}：偷他的口袋，不要殺他。",
	-- ["Horde fly to {area:272}, Alliance to {area:271}. The manor hides in the hills east of {area:272}, up a path into the {zone:1416}; the Rite of Cunning is passing its way in."] = "部落飛往{area:272}，聯盟飛往{area:271}。莊園隱藏在{area:272}東邊的山丘中，沿小路往上進入{zone:1416}；狡詐儀式是你進入的通行方式。",
	-- ["Opens {area:3486}, the hidden rogue house in the Alterac hills, and its first jobs."] = "開啟{area:3486}（奧特蘭克丘陵中隱藏的盜賊據點）及其最初的任務。",
	-- ["Rite of Cunning"] = "狡詐儀式",
	-- ["{item:275482}: pickpocket Barton"] = "{item:275482}：對巴爾頓偷竊",
	-- ["{npc:266216} is inside {area:275}, the Syndicate fortress in eastern {area:287}, south of the manor. Quick and quiet, says {npc:13085}."] = "{npc:266216}在{area:275}內，那是{area:287}東部、莊園南邊的辛迪加要塞。{npc:13085}說：要快又要安靜。",
	-- ["{npc:6766}: {quest:6701}, repeatable"] = "{npc:6766}：{quest:6701}，可重複",
}
