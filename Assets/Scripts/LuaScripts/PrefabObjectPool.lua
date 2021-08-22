--对象池管理类



PrefabObjectPool={}
PrefabObjectPool.__index = PrefabObjectPool

function PrefabObjectPool:New()
	local self = {}
	setmetatable(self,PrefabObjectPool)
	self.List = {}
	self.ListCount=0
	-- self.usedItems 
	-- self.capcity = capcity
	return self
end



-- 从对象池中获取一个对象，若池为空的，则从Prefab创建一个新的
-- 当对象到达池上限时，会把最早使用的对象回收并作为新对象返回
function PrefabObjectPool:Get(ObjName)
	local obj = nil
	local name=ObjName.."(Clone)"
	--如果列表存有量为0，则新生成
	if self.ListCount == 0 then
		-- if self.usedItems.Count == self.capcity then
		-- 	obj = self.usedItems[0]
		-- 	obj:SetActive(false)
		-- 	self.usedItems:RemoveAt(0)
		-- else
			obj = GameObject.Instantiate(A_CtrlMgr.abDTObj:PrefabAB(ObjName))
		--end
	--列表种有对象
	else
		--如果找到目标对象，返回
		for i,v in pairs(self.List) do
			if(v.name==ObjName) then
				--获得对象
				obj=v
				--从对象池种移除
				table.remove(self.List,i)
				--对象池数量-1
				self.ListCount=self.ListCount-1
				break
			end
		end
		--没找到，生成对象
		obj=GameObject.Instantiate(A_CtrlMgr.abDTObj:PrefabAB(ObjName))
	end

	obj:SetActive(true)
	return obj
end

-- 回收一个对象到对象池
function PrefabObjectPool:Put(obj)
	-- if self.usedItems:Contains(obj) then
	-- 	self.usedItems:Remove(obj)
	-- 	obj:SetActive(false)
	-- 	self.List:Enqueue(obj)
	-- else
	-- 	error("[PrefabObjectPool]invalid state")
	-- end
	--插入对象池
	table.insert(self.List,obj)
	--禁用
	obj:SetActive(false)
	--列表大小+1
	self.ListCount=self.ListCount+1
end



-- -- 将所有被使用的对象全部回收
-- function PrefabObjectPool:RecycleAll()
-- 	local count = self.usedItems.Count
-- 	for i=count-1,0, -1 do
-- 		local item = self.usedItems[i]
-- 		self:Put(item)
-- 	end
-- 	self.usedItems:Clear()
-- end

-- --清空对象池Destroy
-- function PrefabObjectPool:Clear()

-- 	self:RecycleAll();

-- 	for i = 0, self.List.Count - 1 do
-- 		GameObject.Destroy(self.List:Dequeue());
-- 	end

-- 	self.List:Clear();
-- end

-- 预先生成指定个数的对象
-- count 需要生成的个数，最大不能超过池大小，若为空则表示直接将池填充满
-- function PrefabObjectPool:Prewarm(count)
-- 	if count == nil then
-- 		if self.capcity == nil then
-- 			error("[PrefabObjectPool]invalid state")
-- 		else
-- 			count = self.capcity
-- 		end
-- 	elseif count > self.capcity then
-- 		count = self.capcity
-- 	end

-- 	for i=1,count do
-- 		local obj =  GameObject.Instantiate(self.prefab)
-- 		self:Put(obj)
-- 	end
-- end
