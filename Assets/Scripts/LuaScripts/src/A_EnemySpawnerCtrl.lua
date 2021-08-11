
--怪物生成逻辑
--获取怪物数据
require("TestSysDefine")
require("A_LevelSettings")
--游戏结算脚本
require("A_SettlementCtrl")
--计时器脚本
-- require("A_GameManager")

--敌人列表
EnemyListSpawnered={}


A_EnemySpawnerCtrl={}
local this=A_EnemySpawnerCtrl

--现存敌人数量
EnemyCount=0
--拿到敌人加载的cs脚本
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()
--拿到敌人数据的实例
local levelData=A_LevelSettings.GetInstance()
--敌人结算脚本的实例
local settlementCtrl=A_SettlementCtrl.GetInstance()
-- --记载计时器脚本实例
-- local timer=A_GameManager.GetInstance()
--存放敌人实例
local tempObj={}
--敌人生成位置
local EnemyPosition=CSU.GameObject.Find("SatrtPosition").transform.position


function A_EnemySpawnerCtrl.GetInstance()
	print("进入敌人生成管理类")
    return this
end

--------------------------------------敌人生成逻辑-------------------------------------------
function A_EnemySpawnerCtrl.Start(obj)
     --加载敌人List
     -- local levelnameCom=CSU.GameObject.Find("LevelName")
     -- local levelname=levelnameCom.Getchild(0)

     local Level=levelData[obj.tag]
     --读取敌人种类进行加载
     for i,wave in pairs(Level.enemy) do
        tempObj[wave.type]=abDTObj:PrefabAB(wave.type)
     end
     --按波数生成敌人
     this.enemySpawner(Level.enemy)
     --成功加载完所有敌人并全部被消灭，游戏胜利
     A_SettlementCtrl.Win()
end


function A_EnemySpawnerCtrl.enemySpawner(LevelDataEnemy)
      for i,wave in pairs(LevelDataEnemy) do
         print(wave.count)
         for i=1,wave.count do
            --实例化
            local enemyObj=CS.UnityEngine.Object.Instantiate(tempObj[wave.type],EnemyPosition,CSU.Quaternion.identity)
            --附加脚本
            CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaUIForm(enemyObj)
            local Eneagent = enemyObj:GetComponent(typeof(CSU.AI.NavMeshAgent))
            Eneagent.speed=wave.speed
            EnemyCount=EnemyCount+1
            --等待生成间隔
            
         end
         --等待上一波敌人全部被消灭
     end
end


function A_EnemySpawnerCtrl.Update()
   
end

