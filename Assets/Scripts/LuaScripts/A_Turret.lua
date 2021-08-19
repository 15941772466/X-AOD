
--炮塔属性，行为方法


A_Turret={
gameObject=nil,
--调用游戏工具类
tool=GameTool.GetInstance(),
--调用DefenseManager脚本
abDTObj=CS.PFW.DefenseManager.GetInstance(),

EnemyList=nil,
--列表敌人数量
EnemyListCount=0,
--列表中第一个敌人
ListFirst=nil,
--攻击间隔
attackRateTime=nil,
--已经等待时间
timer=nil,
--子弹
Bullet=nil,
--开火位置
FirePosition=nil,
--头部炮管
Head=nil,

--子弹类所需属性
--伤害
damage=nil,
--炮塔类型
TurretType=nil,
--子弹速度
BulletSpeed=nil,
--关卡信息
Level=nil,
--中间参数
index=0,
--激光攻击方式的激光
LaserRenderer=nil
}
A_Turret.__index = A_Turret



--实例化对象
function A_Turret:New(Obj,turretType,level)
   -- body
   local temp = {}
   setmetatable(temp,A_Turret)
   --初始化视野范围内敌人列表
   temp.EnemyList=A_BaseList:New()
   --获取炮塔类型
   temp.TurretType=turretType
   --获取关卡信息
   temp.Level=level
   --炮塔实例物体
   temp.gameObject = Obj
   --已等待CD
   temp.timer=0
   --炮塔头部
   temp.Head=Obj.transform:Find("Head")
   --炮塔开火位置
   temp.FirePosition=Obj.transform:Find("Head/FirePosition")   
   --对应bullet的预制体
   temp.Bullet=temp.abDTObj:PrefabAB(level.turretAttributes[turretType].Bullet)
   --子弹的伤害
   temp.damage=level.turretAttributes[turretType].damage
   --子弹的速度
   temp.BulletSpeed=level.turretAttributes[turretType].speed
   --子弹CD
   temp.attackRateTime=level.turretAttributes[turretType].BulletattackRateTime
   --如果是激光塔，加载激光
   if(temp.TurretType=="DefenseC") then
      temp.LaserRenderer=Obj.transform:Find("Laser"):GetComponent(typeof(CSU.LineRenderer))
   end

   return temp
end



function A_Turret:Update()
   --刷新视野
   self:UpdateEnemyView()
   --取到敌人列表中第一个不为nil的值
   self.ListFirst=self:UpdateEnemyLast()
   --子弹攻击方式

   --当敌人列表第一个不为nil的元素存在
   if(self.ListFirst~=nil) then
      ----------------  目标朝向-----------------
      --找到目标敌人
      local targetPosition=self.ListFirst.transform.position
      --固定y轴
      targetPosition.y=self.Head.position.y
      --朝向敌人
      self.tool:LookAt(self.Head,targetPosition)
      ----------------子弹攻击方式---------------
      if(self.TurretType~="DefenseC") then
         --如果附近有敌人且冷却时间已过
         self.timer=self.timer+CSU.Time.deltaTime
         if(self.ListFirst~=nil and self.timer>=self.attackRateTime) then
            --发动攻击
            self:Attack()
            --等待时间置零
            self.timer=0
         end
      ---------------激光攻击方式------------------
      elseif self.ListFirst~=nil then
         --打开激光
         if(self.LaserRenderer.enabled==false) then
            self.LaserRenderer.enabled=true
         end   
         --设置激光指向
         self.tool:SetPositons(self.LaserRenderer,self.FirePosition,self.ListFirst.transform)
         -------------------------------又一次用到寻找所在类的方法，需要封装-------------------------------
         -- self.ListFirst:Takedamage(self.attackRateTime*CSU.Time.deltaTime)
         for i,v in pairs(A_EnemyManager.EnemySelfList) do
            if v.gameObject==self.ListFirst then
              v:Takedamage(self.attackRateTime*CSU.Time.deltaTime)
            end
          end
      end
   end
   if(self.TurretType=="DefenseC" and self.ListFirst==nil) then
      --附近无敌人
      self.LaserRenderer.enabled=false 
   end
end


function A_Turret:Attack()

   if(self.ListFirst~=nil ) then
      local bullet=CSU.Object.Instantiate(self.Bullet,self.FirePosition.position,self.FirePosition.rotation)
      --实例化子弹类
      local BulletObj=A_BulletAB:New(bullet,self.damage,self.BulletSpeed,self.ListFirst)
      self.index = self.index + 1
      --存入它的索引
      BulletObj.IndexSelf=self.index
       --存入子弹列表
      A_BulletManager.Bulletlist[self.index] = BulletObj
   end

end

--刷新敌人进入退出视野时的变化
function A_Turret:UpdateEnemyView()
   --遍历敌人全局列表中不为nil的值
   for i,v in pairs(A_EnemySpawnerCtrl.EnemyListSpawnered) do
      if(v~=nil) then
         --距离小于等于5 且 列表不包含此物体，进入视野 
         if(self.tool:IsOnTriggerEnter(self.gameObject,v) and self.EnemyList:Contains(v)==false) then
            self.EnemyList:Add(v)
            --table.insert(self.EnemyList,v)
            self.EnemyListCount=self.EnemyListCount+1
            print("炮塔类型："..self.gameObject.name.."          第"..i.."个敌人进入视野")
         end
         --距离大于5 且 列表包含此物体，退出视野 
         if(self.tool:IsOnTriggerExit(self.gameObject,v) and self.EnemyList:Contains(v)==true) then
            -- local index=self:Find(v)
            -- if(index~=nil) then
            --    table.remove(self.EnemyList,index)
            --    self.EnemyListCount=self.EnemyListCount-1
            --    print("第"..i.."个敌人退出视野")
            -- end
            --移出列表
            self.EnemyList:FindDelete(v,self.EnemyListCount)
            self.EnemyListCount=self.EnemyListCount-1
            print("炮塔类型："..self.gameObject.name.."          第"..i.."个敌人退出视野")
         end
      end
   end
end



--刷新敌人死亡产生的列表第一个不为nil的元素
function A_Turret:UpdateEnemyLast()
   local First=nil
   --在EnemyList中不为nil
   for i,u in pairs(self.EnemyList.Data) do
      --在全局敌人列表中也不为nil
      for j,v in pairs(A_EnemySpawnerCtrl.EnemyListSpawnered) do
         --找到了第一个跳出
         if u==v then
             First=self.EnemyList.Data[i]
             return First
         end
      end
   end
   return First
end

-- --敌人列表是否已经包含某个敌人物体
-- function A_Turret:Contains(item)
--    for i,v in pairs(self.EnemyList) do
--        if self.EnemyList[i] == item then
--            return true
--        end
--    end
--    return false
-- end

-- --敌人列表中某个敌人的下标
-- function A_Turret:Find(item)
--    local index=0
--    for i=1,self.EnemyListCount do
--       if(self.EnemyList[i]==item) then
--          index=i
--          return index
--       end
--    end
--    return nil
-- end


--全局敌人列表中某个敌人的下标
-- function A_Turret:FindAll(item)
--    local index=0
--    for i=1,A_EnemySpawnerCtrl.Enemycount do
--       if(A_EnemySpawnerCtrl.EnemyListSpawnered[i]==item) then
--          index=i
--          return index
--       end
--    end
--    return nil
-- end
