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
--当前敌人的实例
local EnemyObj
--总血量
local TotalHp
--当前血量
local Hp
-- 拿到敌人血条组件
local HpSliderObjtmp

function A_Enemy1.Awake(obj)
	print("敌人自动寻路")
	--获取当前敌人实例
	EnemyObj=obj
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
    -- 拿到敌人血条组件
    HpSliderObjtmp=obj.transform:Find("Hp/Slider")
    --print(HpSliderObjtmp)
    this.TakeDamage(30)
end

function A_Enemy1.Update(obj)
  --保持血条朝向
  --tool:KeepRotate(HpObj)
end

--脚本销毁
function A_Enemy1.OnDestroy()

end


--收到伤害
function A_Enemy1.TakeDamage(damage)
   tool:UpdateHp(EnemyObj,damage,Hp,TotalHp)
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
