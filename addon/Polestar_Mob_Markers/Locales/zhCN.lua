-- Chinese (simplified) (zhCN): Polestar: Mob Markers' interface strings.
-- Keys are the English strings exactly as the code writes them; a key
-- missing here, or commented out, shows in English. Grouped by the file that
-- first uses each key. docs/TRANSLATING.md explains the rest.

local _, ns = ...
if not (GetLocale and GetLocale() == "zhCN") then return end
local L = ns.L

-- MobMarkers.lua
L["Polestar pastels"] = "Polestar 柔彩"
L["Polestar rings"] = "Polestar 环色"
L["Vivid"] = "鲜艳"
L["Muted"] = "柔和"
L["Colour-blind safe"] = "色盲友好"
L["Light & night"] = "明与夜"
L["Mob spawns"] = "怪物刷新点"
L["Mob spawns on the world map"] = "地图上的怪物刷新点"
L["Every spawn point of the mobs your quests need, one skull colour per quest and a ring per mob."] = "你的任务所需怪物的每个刷新点：每个任务一种骷髅颜色，每种怪物一个圆环。"
L["Legend"] = "图例"
L["Lists the quests and mobs on the shown map. Hover a row to highlight its markers, click it to turn them off or on."] = "列出当前地图上的任务和怪物。鼠标悬停在某一行上可高亮其标记，点击可关闭或打开它们。"
L["Mob spawns on the minimap"] = "微缩地图上的怪物刷新点"
L["The same spawn markers on the minimap."] = "在微缩地图上显示同样的刷新点标记。"
L["Only the current step's mobs"] = "仅当前步骤的怪物"
L["Marks only the quests Polestar's current guide step works on, not your whole quest log. With no guide running, the whole log shows."] = "只标记 Polestar 指南当前步骤涉及的任务，而不是整个任务日志。没有运行指南时显示整个日志。"
L["Quest colours"] = "任务颜色"
L["The colours quests are given, in quest-log order: the skull's colour. The first quest keeps the skull's own colours."] = "按任务日志顺序分配给任务的颜色，即骷髅的颜色。第一个任务保留骷髅本身的颜色。"
L["Mob colours"] = "怪物颜色"
L["The colours of the rings that tell a quest's mobs apart. A quest with one mob has no ring."] = "用来区分同一任务中各种怪物的圆环颜色。只有一种怪物的任务没有圆环。"
L["World map marker size"] = "地图标记大小"
L["Minimap marker size"] = "微缩地图标记大小"
L["The medallion is drawn 1.6 times this."] = "徽章按此大小的 1.6 倍绘制。"
L["Medallion opacity"] = "徽章不透明度"
L["How solid the medallion under each skull is."] = "每个骷髅下方徽章的浓淡程度。"
L["Skull & ring opacity"] = "骷髅和圆环不透明度"
L["How solid the skull and the mob ring are."] = "骷髅和怪物圆环的浓淡程度。"
L["Preview: a full quest log"] = "预览：满载的任务日志"
L["Marks 20 of your faction's quests for whatever zone the world map shows, instead of your quest log. Off again after a reload; also /pmm preview."] = "为地图所显示的区域标记你所在阵营的 20 个任务，而不是你的任务日志。重载后自动关闭；也可用 /pmm preview。"
