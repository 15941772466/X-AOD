--子弹控制管理

A_BulletAB={
  --调用游戏工具类
  tool=GameTool.GetInstance(),
  --子弹物体本身
  gameObject,
  --子弹伤害
  Damage,
  --子弹速度
  Speed,
  --子弹目标
  Target,
  --索引
  IndexSelf=nil
}

A_BulletAB.__index = A_BulletAB
function A_BulletAB:New(Obj,damage,speed,target)
   -- body
   local temp = {}
   setmetatable(temp,A_BulletAB)
   temp.gameObject=Obj
   temp.Target=target
   temp.Damage=damage
   temp.Speed=speed
   return temp
end

function A_BulletAB:Update()
    --找到该敌人在全局敌人列表中的位置
    local IsTargetAlive=self:UpdateTarget()
    if(self.IsTargetAlive==false) then
      print("敌人不存在  删除！")
    	self:Die()
    end
    self.tool:KeepY(self.gameObject,self.Target)
    self.tool:LookAt(self.gameObject.transform,self.Target.transform.position)
    --self.gameObject.transform.LookAt(Target)
    self.tool:Translate(self.gameObject,self.Speed)
    local Distance=self.gameObject.transform.position-self.Target.transform.position
    --距离小于一定数值，判断为碰撞
    if(self.tool:IsReach(self.gameObject,self.Target)) then
        --扣血
        for i,v in pairs(A_EnemyManager.EnemySelfList) do
          if v.gameObject==self.Target then
            v:Takedamage(self.Damage)
          end
        end
        --删除自身
        self:Die()
    end
end

function A_BulletAB:Die()
   self.gameObject:SetActive(false)
   A_BulletManager:Remove(self)
   --self.gameObject:GetComponent("BulletAB"):DestroyGameObject()
end

function A_BulletAB:UpdateTarget()
   for i, v in pairs(A_EnemySpawnerCtrl.EnemyListSpawnered) do
      if(v==self.Target) then
         return true
      end
   end
   return false
end