
A_BaseEnemyList={}


A_BaseEnemyList.__index=A_BaseEnemyList
function A_BaseEnemyList:New()
	local temp={}
	setmetatable(temp,A_BaseEnemyList)

	return temp
end


function A_BaseEnemyList:Add(item)
    table.insert(self, item)
end