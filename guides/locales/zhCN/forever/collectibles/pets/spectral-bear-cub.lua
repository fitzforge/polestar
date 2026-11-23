-- Chinese (simplified) (zhCN): the guide forever/collectibles/pets/spectral-bear-cub (forever/collectibles/pets/spectral-bear-cub.guide).
-- Written by `forge i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Innkeeper Wiley in Ratchet
	-- {npc:6791} Innkeeper Wiley · {area:392} Ratchet
	["{npc:6791} in {area:392}"] = "{area:392}的{npc:6791}",
	-- {item:281060} Replica Ironforge Air Rifle · {item:277714} Spectral Bear Cub · {item:277717} Spectral Bear Tabard · {item:277718} Reins of the Spectral Bear · {npc:6791} Innkeeper Wiley · {area:392} Ratchet · {zone:1413} Barrens · {area:35} Booty Bay · {quest:96383} Legacy Reward: Spectral Bear Cub
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, a crafting profession at 150, 225 and 300, PvP ranks and battleground reputations, exploring, dungeons and raids) is worth one, and the track counts points earned, not spent. It gives the {item:281060} at 15, the {item:277714} at 25, the {item:277717} at 40 and the {item:277718} at 55. The rewards are claimed as quests from {npc:6791} in the inn at {area:392}, the goblin port on the {zone:1413} coast (Alliance players come by the boat from {area:35}): with 25 points he offers {quest:96383}; hand it straight back for the cub."] = "传承点数为账号共享：每项传承挑战（某职业达到25、45、60级，制造专业达到150、225、300点，PvP军衔和战场声望、探索、地下城及团队副本）各奖励一点，进度按累计获得的点数计算，不扣除已花费的点数。达到15点奖励 {item:281060}，25点奖励 {item:277714}，40点奖励 {item:277717}，55点奖励 {item:277718}。奖励以任务形式在 {area:392} 旅店的 {npc:6791} 处领取，这座地精港口位于 {zone:1413} 海岸（联盟玩家可从 {area:35} 坐船前往）：达到25点时，他会提供 {quest:96383}；接取后立即交还即可获得幼崽。",
	["Without PvP one character can earn 17 points: its class at 25, 45 and 60, two professions to 300, the two adventure challenges, the three dungeon tiers and the three raids. A second class or more professions on an alt make up the rest; the Legacy Challenges guide plans them."] = "不参与PvP，单个角色可以获得17点：本职业达到25、45和60级，两个专业升到300点，两项冒险挑战、三个地下城档次和三个团队副本。用小号再练一个职业或更多专业，即可补足其余点数；传承挑战指南会为你安排。",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["25 Legacy Points"] = "25点传承点数",
	-- ["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {item:277714} at 25, the {item:277717} at 40 and the {item:277718} at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the cub is in your bags."] = "传承点数是账号通用的：每项传承挑战（一个职业达到25、45和60级、专业、PvP、探索）计1点。进度轨道在15点给予{item:281060}，25点给予{item:277714}，40点给予{item:277717}，55点给予{item:277718}。奖励如何发放尚不清楚（可能通过邮件）；幼崽进入背包后此目标即完成。",
}
