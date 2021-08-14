--敌人生成管理类

----------------引用脚本-----------------------
--怪物生成逻辑
require("TestSysDefine")
--获取关卡数据
require("A_LevelSettings")
--游戏结算脚本
require("A_SettlementCtrl")



--模拟类
A_EnemySpawnerCtrl={}
local this=A_EnemySpawnerCtrl
--调用游戏工具类
local tool=GameTool.GetInstance()

----------------关于敌人的数据等------------------
--拿到敌人加载的cs脚本
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()
--拿到敌人数据的实例
local levelData=A_LevelSettings.GetInstance()
--敌人列表
EnemyListSpawnered={}
--现存敌人数量
EnemyCount=0
--存放敌人预制体
local tempObj={}
--存放敌人血条UI
local tempSlider

--关卡信息
local Level
--敌人结算脚本的实例
local settlementCtrl=A_SettlementCtrl.GetInstance()
--敌人生成位置
local EnemyPosition=CSU.GameObject.Find("SatrtPosition").transform.position
local Barrel2=CSU.GameObject.Find("Barrel2").transform.position
function A_EnemySpawnerCtrl.GetInstance()
	print("进入敌人生成管理类")
    return this
end

--------------------------------------敌人生成逻辑-------------------------------------------
function A_EnemySpawnerCtrl.Awake(obj)

end
function A_EnemySpawnerCtrl.Start(obj)
     --获取当前关卡
     Level=levelData[obj.tag]
     --读取敌人种类进行加载
     for i,wave in pairs(Level.enemy) do
        tempObj[wave.type]=abDTObj:PrefabAB(wave.type)
     end
     tempSlider=abDTObj:PrefabAB("Hp")
     print(tempSlider.name)
     --按波数生成敌人
     this.enemySpawner(Level.enemy)
     --成功加载完所有敌人并全部被消灭，游戏胜利
     A_SettlementCtrl.Win()
end

--敌人生成
function A_EnemySpawnerCtrl.enemySpawner(LevelDataEnemy)
   local enemyObj=CSU.Object.Instantiate(tempObj["A_Enemy1"],EnemyPosition,CSU.Quaternion.identity)
   local enemySlider=CSU.Object.Instantiate(tempSlider,EnemyPosition,CSU.Quaternion.identity)
   --附加脚本
   CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaEnemy(enemyObj)
     --  for i,wave in pairs(LevelDataEnemy) do
     --     print(wave.count)
     --     for i=1,wave.count do
     --        --实例化
     --        local enemyObj=CSU.Object.Instantiate(tempObj[wave.type],EnemyPosition,CSU.Quaternion.identity)
     --        --local enemySlider=CSU.Object.Instantiate(tempSlider,EnemyPosition,CSU.Quaternion.identity)
     --        --附加脚本
     --        CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaEnemy(enemyObj)
     --        --local EnemyScript=enemyObj:GetComponent("BaseLuaEnemy")
     --        --EnemyScript:GetSliderUI(enemySlider)
     --        local Eneagent = enemyObj:GetComponent(typeof(CSU.AI.NavMeshAgent))
     --        Eneagent.speed=wave.speed
     --        EnemyCount=EnemyCount+1
     --        --等待生成间隔
            

     --     end
     --     --等待上一波敌人全部被消灭
     -- end
end


function A_EnemySpawnerCtrl.Update()
   
end

