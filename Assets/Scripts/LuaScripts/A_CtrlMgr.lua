--控制层管理器


A_CtrlMgr={}
local this=A_CtrlMgr

local ctrlList={}

function A_CtrlMgr.Init()


    --------------------------加载建造管理脚本-------------------------------------------
	print("加载炮塔生成管理脚本")
	--拿到炮塔建造管理空物体
	local buildManager=CSU.GameObject.Find("A_BuildManagerCtrl")
	CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaUIForm(buildManager)
	-- local BuildObj=A_BuildManagerCtrl.GetInstance() --得到建造管理类的实例
    -- BuildObj.StartProcess()
	--------------------------加载敌人生成管理脚本----------------------------------------
	--需要根据关卡不同执行不同的敌人生成函数
	print("加载敌人生成管理脚本")
	--拿到敌人生成管理空物体
	local enemyspawner=CSU.GameObject.Find("A_EnemySpawnerCtrl")
	CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaUIForm(enemyspawner)
	-- local EneObj=A_EnemySpawnerCtrl.GetInstance() --得到敌人生成管理类的实例
	-- EneObj.StartProcess(LevelSettings.levelOne_enemy)
    

end


