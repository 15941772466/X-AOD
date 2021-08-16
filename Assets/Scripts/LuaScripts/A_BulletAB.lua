--子弹控制管理

require("A_LevelSettings")

A_BulletAB={
  --调用游戏工具类
  tool=GameTool.GetInstance(),
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
function A_BulletAB:New(Obj,damage,speed)
   -- body
   local temp = {}
   setmetatable(temp,A_BulletAB)
   temp.gameObject=Obj
   temp.Target=temp.gameObject:GetComponent("BulletAB"):GetTarget()
   temp.Damage=damage
   temp.Speed=speed
   return temp
end

function A_BulletAB:Update()
    
    if(self.Target==nil or self.gameObject==nil ) then
    	--self:Die()
    	return
    end
    self.tool:KeepY(self.gameObject,self.Target)
    self.tool:LookAt(self.gameObject.transform,self.Target.position)
    --self.gameObject.transform.LookAt(Target)
    self.tool:Translate(self.gameObject,self.Speed)
    local Distance=self.gameObject.transform.position-self.Target.position
    --距离小于一定数值，判断为碰撞
    if(self.tool:IsReach(self.gameObject,self.Target)) then
        --扣血
        self.Target:GetComponent("Enemy"):Takedamage(self.Damage)
        --删除自身
        self:Die()
    end
end

function A_BulletAB:Die()
 
   A_BulletManager:Remove(self)
   self.gameObject:GetComponent("BulletAB"):DestroyGameObject()

end