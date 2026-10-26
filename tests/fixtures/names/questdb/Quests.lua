-- A hand-made Polestar_QuestDB file (forge data questdb's layout: LuaChunks, one record a line).
local Q = Polestar and Polestar.QuestDB
if not (Q and Q.AddChunk) then return end
local R = Q.AddChunk
R("quests", 7, 35, [[

7	'Kobold Camp Cleanup;4;2;;;;197;197;;;;{1,6,10
35	'Further Concerns;10;8
]])
