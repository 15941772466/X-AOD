
--炮塔属性，行为方法


Turret={
gameObject=nil,
--调用游戏工具类
tool=GameTool.GetInstance(),
--调用DefenseManager脚本
abDTObj=CS.PFW.DefenseManager.GetInstance(),
--视野范围内敌人列表
EnemyList={},
--敌人列表Count
ListCount=0,
--攻击间隔
attackRateTime=1,
--已经等待时间
timer=nil,
--子弹
Bullet=nil,
--开火位置
FirePosition=nil,
--头部炮管
Head=nil
}
Turret.__index = Turret



--实例化对象
function Turret:New(Obj)
   -- body
   local temp = {}
   setmetatable(temp,Turret)
   
   temp.gameObject = Obj
   temp.timer=0
   temp.Head=Obj.transform:Find("Head")
   temp.FirePosition=Obj.transform:Find("Head/FirePositoin")   
   temp.Bullet=self.abDTObj:PrefabAB("DeABullet")
   return temp
end



function Turret:Update()
   self.EnemyList=self.gameObject:GetComponent("BaseLuaTurret"):GetEnemyList(self.EnemyList)
   self.ListCount=self.EnemyList.Count
   --print("防御塔：  "..self.gameObject.name.."  视野内敌人数量：  "..self.EnemyList.Count.."  视野内第一关敌人：  "..self.EnemyList[1].name)
   print("防御塔：  "..self.gameObject.name)
   --如果附近有敌人
   if(self.ListCount>0) then
        --找到目标敌人
      local targetPosition=self.EnemyList[1].transform.position
      --固定y轴
      targetPosition.y=self.Head.position.y
      --朝向敌人
      self.tool:LookAt(self.Head,targetPosition)
   end
   --如果附近有敌人且冷却时间已过
   --self.timer=self.tool:UpdateTimer(self.timer)
   
   self.timer=self.timer+CSU.Time.deltaTime

   if(self.ListCount>0 and self.timer>=self.attackRateTime) then
        --发动攻击
        self:Attack()
        --等待时间置零
        self.timer=0
   end
end


function Turret:Attack()
   print("Biu~")
   print("视野内敌人：  "..self.ListCount)
   if(self.ListCount>0) then
      local bullet=CSU.Object.Instantiate(self.Bullet,self.FirePosition.position,self.FirePosition.rotation)
      --CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaDeABullet(bullet)
     -- bullet:GetComponent("BaseLuaBulletA"):Gettarget(EnemyList[1].transform)
   end

end




-----------------更新视野内敌人列表----------------------
--进入视野，添加
-- function Turret:OnTriggerEnter(collider)
--    table.insert(EnemyList,collider.gameObject)
--    ListCount=ListCount+1
--    --print("进入视野"..ListCount)
-- end
-- --推出视野，删除
-- function Turret:OnTriggerExit(collider)
--    --EnemyList[collider.gameObject]=nil
--    for k,v in pairs(EnemyList) do
--       if(v==collider.gameObject) then
--          table.remove(EnemyList,k)
--          break
--       end
--    end
--    ListCount=ListCount-1
--    --print("退出视野"..ListCount)
-- end
