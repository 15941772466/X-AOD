--Enemy1的控制类

--获取怪物数据
require("A_LevelSettings")
--游戏结算脚本
require("A_SettlementCtrl")

--设置单例
A_Enemy={
   --物体自身
   gameObject=nil,
   --调用游戏工具类
   tool=GameTool.GetInstance(),
   --设置Enemy1的属性参数
   LevelData=A_LevelSettings.GetInstance(),
   --敌人血条Canvas
   HpUI=nil,
   --敌人血条Slider
   HpSlider=nil,
   --当前敌人的实例
   EnemyObj=nil,
   --总血量
   TotalHp=nil,
   --当前血量
   Hp=nil,
   --目标位置
   GoalPosition=nil,
   --自身索引
   IndexSelf=nil
}

A_Enemy.__index=A_Enemy
function A_Enemy:New(Obj)
   local temp = {}
   setmetatable(temp,A_Enemy)
   --拿到物体实例
   temp.gameObject=Obj
   --拿到血条UI
   temp.Canvas=Obj:GetComponent("Enemy"):SendCanvasToLua()
   --找到目标位置并设置
   temp.GoalPosition=CSU.GameObject.Find("EndPosition").transform.position
   Obj:GetComponent(typeof(CSU.AI.NavMeshAgent)).destination=temp.GoalPosition
  
   return temp
end




function A_Enemy:Update()
  --保持血条跟随
  --HpSlider.position=EnemyObj.position
  
  self.Canvas.transform.position=self.gameObject.transform.position
  self.tool:SliderUp(self.Canvas)
  self.Hp=self.gameObject:GetComponent("Enemy"):SendCurrentHpToLua()

  --没血了，执行死亡
  if(self.Hp~=nil and self.Hp<=0) then
     self:Die()
  end
end

--脚本销毁
function A_Enemy.OnDestroy()

end


--收到伤害，被子弹所调用
function A_Enemy.TakeDamage(obj,damage)
   --扣血
   Hp=Hp-damage
   --更改血条显示
   -- local HpSlider=obj.transform:Find("Hp/HpSlider").gameObject:GetComponent("UnityEngine.UI.Slider")
   -- HpSlider.value=Hp/TotalHp
   --血量为0，敌人死亡
   if(Hp<=0) then
   	 this.Die()
   end
end

--到达终点，战败
function A_Enemy.ReachDestination()
    
end

--敌人死亡
function A_Enemy:Die()
   print("敌人死亡")
   A_EnemyManager:Remove(self)
   self.gameObject:GetComponent("Enemy"):CloseEnemy()

end
