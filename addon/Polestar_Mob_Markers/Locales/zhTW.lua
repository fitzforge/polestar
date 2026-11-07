-- Chinese (traditional) (zhTW): Polestar: Mob Markers' interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "zhTW") then return end
local L = ns.L

-- MobMarkers.lua
L["Polestar pastels"] = "Polestar 柔彩"
L["Polestar rings"] = "Polestar 環色"
L["Vivid"] = "鮮豔"
L["Muted"] = "柔和"
L["Colour-blind safe"] = "色盲友善"
L["Light & night"] = "明與夜"
L["Mob spawns"] = "怪物重生點"
L["Mob spawns on the world map"] = "地圖上的怪物重生點"
L["Every spawn point of the mobs your quests need, one skull colour per quest and a ring per mob."] = "你的任務所需怪物的每個重生點：每個任務一種骷髏顏色，每種怪物一個圓環。"
L["Legend"] = "圖例"
L["Lists the quests and mobs on the shown map. Hover a row to highlight its markers, click it to turn them off or on."] = "列出目前地圖上的任務和怪物。滑鼠停在某一列上可醒目顯示其標記，點擊可關閉或開啟它們。"
L["Mob spawns on the minimap"] = "小地圖上的怪物重生點"
L["The same spawn markers on the minimap."] = "在小地圖上顯示同樣的重生點標記。"
L["Only the current step's mobs"] = "僅目前步驟的怪物"
L["Marks only the quests Polestar's current guide step works on, not your whole quest log. With no guide running, the whole log shows."] = "只標記 Polestar 指南目前步驟處理的任務，而不是整個任務日誌。沒有執行中的指南時顯示整個日誌。"
L["Quest colours"] = "任務顏色"
L["The colours quests are given, in quest-log order: the skull's colour. The first quest keeps the skull's own colours."] = "依任務日誌順序分配給任務的顏色，也就是骷髏的顏色。第一個任務保留骷髏本身的顏色。"
L["Mob colours"] = "怪物顏色"
L["The colours of the rings that tell a quest's mobs apart. A quest with one mob has no ring."] = "用來區分同一任務中各種怪物的圓環顏色。只有一種怪物的任務沒有圓環。"
L["World map marker size"] = "地圖標記大小"
L["Minimap marker size"] = "小地圖標記大小"
L["The medallion is drawn 1.6 times this."] = "徽章依此大小的 1.6 倍繪製。"
L["Medallion opacity"] = "徽章不透明度"
L["How solid the medallion under each skull is."] = "每個骷髏下方徽章的濃淡程度。"
L["Skull & ring opacity"] = "骷髏與圓環不透明度"
L["How solid the skull and the mob ring are."] = "骷髏與怪物圓環的濃淡程度。"
