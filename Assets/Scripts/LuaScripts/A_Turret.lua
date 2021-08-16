
--炮塔属性，行为方法


A_Turret={
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
      print(turretType)
      print(level.turretAttributes[turretType].Bullet)
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
   self.EnemyList=self.gameObject:GetComponent("BaseLuaTurret"):GetEnemyList(self.EnemyList)
   self.ListCount=self.EnemyList.Count
   --print("防御塔：  "..self.gameObject.name.."  视野内敌人数量：  "..self.EnemyList.Count.."  视野内第一关敌人：  "..self.EnemyList[1].name)
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


function A_Turret:Attack()
   print("Biu~")
   if(self.ListCount>0) then
      local bullet=CSU.Object.Instantiate(self.Bullet,self.FirePosition.position,self.FirePosition.rotation)
      --读取表
      bullet:GetComponent("BulletAB"):Gettarget(self.EnemyList[1].transform)
      local BulletObj=A_BulletAB:New(bullet,self.damage,self.BulletSpeed)
      self.index = self.index + 1
      --存入它的索引
      BulletObj.IndexSelf=self.index
       --存入子弹列表
      A_BulletManager.Bulletlist[self.index] = BulletObj
   end

end

