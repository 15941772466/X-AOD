
--炮塔属性，行为方法


A_Turret={
gameObject=nil,
--调用游戏工具类
tool=GameTool.GetInstance(),
--调用DefenseManager脚本
abDTObj=CS.PFW.DefenseManager.GetInstance(),
--视野范围内敌人列表
EnemyList={},
--列表敌人数量
EnemyListCount=0,
--列表中第一个敌人
ListFirst=nil,
--攻击间隔
attackRateTime=1,
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
--激光攻击方式
LaserDamageRate=nil,
--中间参数
index=0
}
A_Turret.__index = A_Turret



--实例化对象
function A_Turret:New(Obj,turretType,level)
   -- body
   local temp = {}
   setmetatable(temp,A_Turret)
   --获取炮塔类型
   temp.TurretType=turretType
   --获取关卡信息
   temp.Level=level
   --如果是前两种炮塔
   --if(TurretType~="DefenseC") then
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
   --else
   --   LaserDamageRate=30
   --end
   return temp
end



function A_Turret:Update()
   --刷新视野
   self:UpdateEnemyView()
   --取到敌人列表中第一个不为nil的值
   self.ListFirst=self:UpdateEnemyLast()
   
   --当敌人列表第一个不为nil的元素存在
   if(self.ListFirst~=nil) then
        --找到目标敌人
      local targetPosition=self.ListFirst.transform.position
      --固定y轴
      targetPosition.y=self.Head.position.y
      --朝向敌人
      self.tool:LookAt(self.Head,targetPosition)
   end
   --如果附近有敌人且冷却时间已过
   self.timer=self.timer+CSU.Time.deltaTime
   if(self.ListFirst~=nil and self.timer>=self.attackRateTime) then
        --发动攻击
        self:Attack()
        --等待时间置零
        self.timer=0
   end
end


function A_Turret:Attack()

   if(self.ListFirst~=nil ) then
      local bullet=CSU.Object.Instantiate(self.Bullet,self.FirePosition.position,self.FirePosition.rotation)
      --读取表
      bullet:GetComponent("BulletAB"):Gettarget(self.ListFirst.transform)
      local BulletObj=A_BulletAB:New(bullet,self.damage,self.BulletSpeed)
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
      -- local index=self:FindAll(v)
      -- print("当前扫到的敌人是：：   ")
      -- print(index)
      -- print(A_EnemySpawnerCtrl.EnemyListSpawnered[i])
      if(v~=nil) then
         --距离小于等于5 且 列表不包含此物体，进入视野 
         if(self.tool:IsOnTriggerEnter(self.gameObject,v) and self:Contains(v)==false) then
            table.insert(self.EnemyList,v)
            self.EnemyListCount=self.EnemyListCount+1
            print("第"..i.."个敌人进入视野")
         end
         --距离大于5 且 列表包含此物体，退出视野 
         if(self.tool:IsOnTriggerExit(self.gameObject,v) and self:Contains(v)==true) then
            local index=self:Find(v)
            if(index~=nil) then
               table.remove(self.EnemyList,index)
               self.EnemyListCount=self.EnemyListCount-1
               print("第"..i.."个敌人退出视野")
            end
         end
      end
   end
end

-- function A_Turret:IsOnTriggerEnter(turret,enemy)
--    local DistanceX=turret.transform.position.x-enemy.transform.position.x
--    local DistanceY=turret.transform.position.y-enemy.transform.position.y
--    if DistanceX*DistanceX+DistanceY*DistanceY<=25 then
--       return true
--    end
--    return false
-- end


--刷新敌人死亡产生的列表第一个不为nil的元素
function A_Turret:UpdateEnemyLast()
   local First=nil
   --在EnemyList中不为nil
   for i,u in pairs(self.EnemyList) do
      --在全局敌人列表中也不为nil
      for j,v in pairs(A_EnemySpawnerCtrl.EnemyListSpawnered) do
         --找到了第一个跳出
         if u==v then
             First=self.EnemyList[i]
             return First
         end
      end
   end
   return First
end

--敌人列表是否已经包含某个敌人物体
function A_Turret:Contains(item)
   for i,v in pairs(self.EnemyList) do
       if self.EnemyList[i] == item then
           return true
       end
   end
   return false
end

--敌人列表中某个敌人的下标
function A_Turret:Find(item)
   local index=0
   for i=1,self.EnemyListCount do
      if(self.EnemyList[i]==item) then
         index=i
         return index
      end
   end
   return nil
end
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
