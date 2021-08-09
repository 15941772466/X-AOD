--Enemy1的控制类

require("TestSysDefine")
--require("A_EnemySpawnerCtrl")
A_Enemy1={}
local this=A_Enemy1
--Enemy1的属性参数
EnemyData1={
	speed=10,
	Hp=150,
}	
function A_Enemy1.Awake(obj)
	print("敌人自动寻路")
	--获取敌人的navmesh组件
	local agent = obj:GetComponent(typeof(CSU.AI.NavMeshAgent))
	--获取敌人的目标位置
	local goal=CSU.GameObject.Find("EndPosition")
	--设置目标位置
	agent.destination=goal.transform.position
end

function A_Enemy1.Start(obj)
	print("startLua")
	-- --获取敌人的navmesh组件
	-- local agent = obj:GetComponent(typeof(CSU.AI.NavMeshAgent))
	-- --获取敌人的目标位置
	-- local goal=CSU.GameObject.Find("EndPosition")
	-- --设置目标位置
	-- agent.destination=goal.transform.position
end

function A_Enemy1.StartProcess()
	print("敌人自动寻路")
	--获取敌人的navmesh组件
	local Enemy1Obj=CSU.GameObject.Find("A_Enemy1")
	local agent = Enemy1Obj:GetComponent(typeof(CSU.AI.NavMeshAgent))
	--获取敌人的目标位置
	local goal=CSU.GameObject.Find("EndPosition")
	--设置目标位置
	agent.destination=goal.transform.position
end

--脚本销毁
function A_Enemy1.OnDestroy()

end


--收到伤害
function A_Enemy1.TakeDamage()

end

--到达终点，战败
function A_Enemy1.ReachDestination()
    
end

--敌人死亡
function A_Enemy1.Die()

end
