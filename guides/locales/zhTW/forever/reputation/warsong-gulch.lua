-- Chinese (traditional) (zhTW): the guide forever/reputation/warsong-gulch (forever/reputation/warsong-gulch.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Warsong Gulch Reputation"] = "戰歌峽谷聲望",

	-- Step 1: Silverwing Sentinels to Friendly
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Friendly"] = "{faction:890}到友好",
	-- {faction:890} Silverwing Sentinels · {zone:1460} Warsong Gulch
	["The {faction:890} are the Night Elves holding {zone:1460}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:890}是駐守{zone:1460}的夜精靈。他們的聲望來自戰場：你的隊伍每奪下一面敵方旗幟，整個隊伍都會獲得聲望。在任何戰場軍官處排隊。Forever的傳承外交官天賦可提高聲望獲取。",
	-- {npc:14733} Sentinel Farsong
	["{npc:14733} takes Warsong Gulch Marks of Honor for Vanquish the Invaders!, once per level bracket (data); check them live."] = "{npc:14733}收取戰歌峽谷榮譽獎章以完成「擊敗入侵者！」，每個等級區間一次（資料）；請在遊戲中確認。",

	-- Step 2: Silverwing Sentinels to Honored
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Honored"] = "{faction:890}到尊敬",
	-- {zone:1460} Warsong Gulch · {npc:15351} Alliance Brigadier General
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15351} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "持續參加{zone:1460}並奪旗。在{zone:1460}戰場召集週末，主城的{npc:15351}會收取三枚戰歌峽谷榮譽獎章以提供額外聲望。",
	-- {npc:14753} Illiyana Moonblaze
	["{npc:14753} hands out one Sentinel care package by level"] = "{npc:14753}依等級發放一份哨兵護理包",

	-- Step 3: Silverwing Sentinels to Revered
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Revered"] = "{faction:890}到崇敬",
	-- {zone:1460} Warsong Gulch
	["Keep capturing flags in {zone:1460}."] = "持續在{zone:1460}奪旗。",

	-- Step 4: Silverwing Sentinels to Exalted
	-- {faction:890} Silverwing Sentinels
	["{faction:890} to Exalted"] = "{faction:890}到崇拜",
	-- {faction:890} Silverwing Sentinels
	["Exalted with the {faction:890} earns a Legacy Point."] = "與{faction:890}達到崇拜可獲得1點傳承點數。",

	-- Step 5: Warsong Outriders to Friendly
	-- {faction:889} Warsong Outriders
	["{faction:889} to Friendly"] = "{faction:889}到友好",
	-- {faction:889} Warsong Outriders · {zone:1440} Ashenvale
	["The {faction:889} are the Orcs logging {zone:1440}. Their reputation comes from the battleground: every enemy flag your team captures pays it to the whole team. Queue at any battlemaster. Forever's Legacy Diplomat perk increases reputation gains."] = "{faction:889}是在{zone:1440}伐木的獸人。他們的聲望來自戰場：你的隊伍每奪下一面敵方旗幟，整個隊伍都會獲得聲望。在任何戰場軍官處排隊。Forever的傳承外交官天賦可提高聲望獲取。",
	-- {npc:14781} Captain Shatterskull
	["{npc:14781} takes Warsong Gulch Marks of Honor for Quell the Silverwing Usurpers, once per level bracket (data); check them live."] = "{npc:14781}收取戰歌峽谷榮譽獎章以完成「鎮壓銀翼部隊」，每個等級區間一次（資料）；請在遊戲中確認。",

	-- Step 6: Warsong Outriders to Honored
	-- {faction:889} Warsong Outriders
	["{faction:889} to Honored"] = "{faction:889}到尊敬",
	-- {zone:1460} Warsong Gulch · {npc:15350} Horde Warbringer
	["Keep playing {zone:1460} and capturing flags. On Call to Arms: {zone:1460} weekends the {npc:15350} in the capitals takes three Warsong Gulch Marks of Honor for extra reputation."] = "持續參加{zone:1460}並奪旗。在{zone:1460}戰場召集週末，主城的{npc:15350}會收取三枚戰歌峽谷榮譽獎章以提供額外聲望。",
	-- {npc:14754} Kelm Hargunth
	["{npc:14754} hands out one Outrider care package by level"] = "{npc:14754}依等級發放一份斥候護理包",

	-- Step 7: Warsong Outriders to Revered
	-- {faction:889} Warsong Outriders
	["{faction:889} to Revered"] = "{faction:889}到崇敬",

	-- Step 8: Warsong Outriders to Exalted
	-- {faction:889} Warsong Outriders
	["{faction:889} to Exalted"] = "{faction:889}到崇拜",
	-- {faction:889} Warsong Outriders
	["Exalted with the {faction:889} earns a Legacy Point."] = "與{faction:889}達到崇拜可獲得1點傳承點數。",
}
