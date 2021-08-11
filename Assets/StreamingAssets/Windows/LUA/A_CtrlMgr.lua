--控制层管理器
--功能：    
--    1.缓存访问所有控制层脚本
--    2.提供访问项目中所有控制层脚本的入口函数

--加载敌人生成控制类
require("A_EnemySpawnerCtrl")
require("A_BuildManagerCtrl") 
require("LevelSettings")


A_CtrlMgr={}
local this=A_CtrlMgr
--定义控制器列表
local ctrlList={}

function A_CtrlMgr.Init()
    ---------------------------加载计时器脚本--------------------------------------------
    -- local gameObjectManager=CSU.GameObject.Find("A_GameManager")
    -- print(gameObjectManager.name)
    -- CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaUIForm(gameObjectManager)

    --------------------------加载建造管理脚本-------------------------------------------
	print("加载炮塔生成管理脚本")
	local buildManager=CSU.GameObject.Find("A_BuildManagerCtrl")
	CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaUIForm(buildManager)
	-- local BuildObj=A_BuildManagerCtrl.GetInstance() --得到建造管理类的实例
    -- BuildObj.StartProcess()
	--------------------------加载敌人生成管理脚本----------------------------------------
	--需要根据关卡不同执行不同的敌人生成函数
	print("加载敌人生成管理脚本")
	local enemyspawner=CSU.GameObject.Find("A_EnemySpawnerCtrl")
	CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaUIForm(enemyspawner)
	-- local EneObj=A_EnemySpawnerCtrl.GetInstance() --得到敌人生成管理类的实例
	-- EneObj.StartProcess(LevelSettings.levelOne_enemy)


end


