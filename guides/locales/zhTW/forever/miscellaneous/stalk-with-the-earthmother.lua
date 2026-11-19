-- Chinese (traditional) (zhTW): the guide forever/miscellaneous/stalk-with-the-earthmother (forever/miscellaneous/stalk-with-the-earthmother.guide).
-- Written by `forge i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff
	["A one-hand blade or mace at 11 from {npc:205729}'s three tests in and around {zone:1456}, for a Tauren of any class."] = "11級時完成{npc:205729}在{zone:1456}內外的三項考驗，可獲得一把單手劍或單手錘，適合任何職業的牛頭人。",

	-- Step 1: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206159} Venture Co Disguise · {npc:3051} Supervisor Fizsprocket
	-- plural, as words: Venture Co. Workers = {npc:2978} Venture Co. Worker
	["{npc:205729} hides in stealth on the main mesa of {zone:1456}, south of its pool: walk to where the arrow points until his outline shows. He hands you the {item:206159}. The quest opens at level 4, but the mine holds Venture Co. Workers (level 8-9), Supervisors (9-10) and {npc:3051} (12): go at 9 or 10."] = "{npc:205729}潛行在{zone:1456}主臺地上、水池南邊：走到箭頭所指的位置，直到他的輪廓顯現。他會交給你{item:206159}。任務4級即可接，但礦洞裡有風險投資公司工人（8-9級）、監工（9-10級）和{npc:3051}（12級）：建議9或10級再去。",

	-- Step 2: The Venture Co. Mine
	-- {zone:1412} Mulgore · {area:360} The Venture Co. Mine · {object:403041} Blasting Supplies (no name in this language: may be words)
	["Ride down the lift and south-east across {zone:1412} to the {area:360}. Put on the disguise, then open the carts of {object:403041} inside the mine and on the slope outside it; stay on the upper levels where you can, the lower tunnels are packed. Five charges."] = "坐升降機下去，向東南穿過{zone:1412}到{area:360}。換上偽裝，然後開啟礦洞裡和外面坡上的{object:403041}車；能待在上層就待上層，下層隧道擠得很。五次充能。",
	-- {item:206157} Seaforium Mining Charge · {object:403041} Blasting Supplies (no name in this language: may be words)
	["{item:206157}, from the {object:403041}"] = "{item:206157}，來自{object:403041}",

	-- Step 3: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	["Back to {npc:205729} in {zone:1456}. He gives you the {item:206176} for his next test."] = "回到{zone:1456}的{npc:205729}那裡。他會給你{item:206176}，用於下一項試煉。",

	-- Step 4: Windfury Cones
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones"] = "風怒松果",
	-- {area:819} Windfury Ridge · {zone:1456} Thunder Bluff · {item:206176} Mortar and Pestle
	-- plural, as words: Windfury Cones = {item:206170} Windfury Cone
	["Windfury Cones lie on the ground under the harpies' nest trees on {area:819}, north-west of {zone:1456}; the harpies do not drop them. The Windfury Sorceresses (level 9-10) and Matriarchs (10-11) there stand close together: pick the cones from the edges. Once you have eight, use the {item:206176} to grind them."] = "風怒松果落在{area:819}上鷹身女妖巢樹下的地上，那裡位於{zone:1456}西北；鷹身女妖不會掉落它們。那裡的風怒女巫（9-10級）和女族長（10-11級）站得很近：從邊緣撿松果。湊夠八個後，用{item:206176}把它們磨碎。",
	["the mortar takes all eight"] = "研缽要全部八個",
	-- {item:206175} Pine Salve
	["grind the eight cones into the {item:206175}"] = "把八個錐果在研缽裡磨成{item:206175}",

	-- Step 5: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:206344} Knife Set
	["Back to {npc:205729}. He hands you the {item:206344} for the last test."] = "回到{npc:205729}。他給你{item:206344}，用於最後一項考驗。",

	-- Step 6: Raw Brilliant Smallfish
	-- {item:6291} Raw Brilliant Smallfish · {npc:8674} Auctioneer Stampi · {npc:3028} Kah Mistrunner · {skill:356} Fishing · {npc:3029} Sewa Mistrunner · {item:6256} Fishing Pole · {item:6529} Shiny Bauble · {item:206344} Knife Set
	["Buy a {item:6291} at the Auction House ({npc:8674}, north of the pool), or fish one yourself: {npc:3028} trains {skill:356} and {npc:3029} beside him sells the {item:6256} and a {item:6529}; the pool on the main mesa gives smallfish at any skill. Then use the {item:206344} on it, wherever you are."] = "在拍賣行買一條{item:6291}（{npc:8674}，在水池以北），或者自己釣：{npc:3028}教{skill:356}，他旁邊的{npc:3029}賣{item:6256}和{item:6529}；主臺地的水池隨便什麼技能都能釣到小魚。然後在你所在的地方對它使用{item:206344}。",
	-- {item:6291} Raw Brilliant Smallfish
	["{item:6291}: the Auction House, or the pool; the knife takes it"] = "{item:6291}：拍賣行，或者水池；刀能處理它",
	-- {item:206345} Fish Chunks · {npc:205729} Boarton Shadetotem
	["fillet the smallfish into {item:206345} (where players did it, on the way back to {npc:205729})"] = "把小魚片成{item:206345}（玩家都在這做，就在回{npc:205729}的路上）",

	-- Step 7: Boarton Shadetotem
	-- {npc:205729} Boarton Shadetotem · {item:277988} Hoof-Holstered Blade · {item:278002} Valley Cosh
	["Take your weapon from {npc:205729}: the {item:277988} or the {item:278002}."] = "從{npc:205729}那裡領取武器：{item:277988}或{item:278002}。",
}
