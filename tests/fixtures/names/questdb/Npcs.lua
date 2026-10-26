-- A hand-made Polestar_QuestDB file (forge data questdb's layout: LuaChunks, one record a line).
local Q = Polestar and Polestar.QuestDB
if not (Q and Q.AddChunk) then return end
local R = Q.AddChunk
R("npcs", 6, 448, [[

6	'Kobold Vermin;1429;0;1;47.6;35.1;40
448	'Hogger
]])
