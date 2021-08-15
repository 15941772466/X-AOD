--Enemy1的控制类

--获取怪物数据
require("A_LevelSettings")
--游戏结算脚本
require("A_SettlementCtrl")

--设置单例
A_Enemy1={}
local this=A_Enemy1
--调用游戏工具类
local tool=GameTool.GetInstance()
--设置Enemy1的属性参数
local LevelData=A_LevelSettings.GetInstance()
--敌人血条Canvas
local HpUI
--敌人血条Slider
local HpSlider
--当前敌人的实例
local EnemyObj
--总血量
local TotalHp
--当前血量
local Hp



function A_Enemy1.Awake(obj)
	print("敌人自动寻路")
	--获取当前敌人实例
	EnemyObj=obj
   --获取血条UI
   -- local tempScript=obj:GetComponent("BaseLuaEnemy")
   -- print(tempScript.name)
   -- HpSlider=tempScript.SliderUI
   -- print(HpSlider)
   --获取血条
   --HpSlider=obj.transform:Find("Hp/HpSlider").gameObject:GetComponent("UnityEngine.UI.Slider")
	--获取敌人的navmesh组件s
	local agent = obj:GetComponent(typeof(CSU.AI.NavMeshAgent))
	--获取敌人的目标位置
	local goal=CSU.GameObject.Find("EndPosition")
	--设置目标位置
	agent.destination=goal.transform.position
end

function A_Enemy1.Start(obj)
	--读取Enemy1的属性参数
    LevelData=A_LevelSettings.GetInstance()
    local LevelName=CSU.GameObject.Find("A_EnemySpawnerCtrl").tag
    --获取敌人的血量
    TotalHp=LevelData[LevelName].enemyAttributes["A_Enemy1"].Hp
    --初始化当前血量
    Hp=TotalHp
end

function A_Enemy1.Update(obj)
  --保持血条跟随
  --HpSlider.position=EnemyObj.position
end

--脚本销毁
function A_Enemy1.OnDestroy()

end


--收到伤害，被子弹所调用
function A_Enemy1.TakeDamage(obj,damage)
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
function A_Enemy1.ReachDestination()
    
end

--敌人死亡
function A_Enemy1.Die()
   print("敌人死亡")
end
