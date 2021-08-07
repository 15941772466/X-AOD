
--怪物生成逻辑
--获取怪物数据
-- require("A_Enemy1")

A_EnemySpawnerCtrl={}
local this=A_EnemySpawnerCtrl

function A_EnemySpawnerCtrl.GetInstance()
	print("进入敌人生成管理类")
    return this
end

function A_EnemySpawnerCtrl.StartProcess()
	print("开始处理敌人逻辑")
     --加载敌人 need todo
     --生成敌人
     --if(tmpObj~=nil) then
        --Enemy1Obj=CS.UnityEngine.Object.Instantiate(tmpObj)
        --获取场景中的敌人物体
        Enemy1Obj=CSU.GameObject.Find("A_Enemy1")
        CS.LuaFramework.LuaHelper.GetInstance():AddBaseLuaUIForm(Enemy1Obj)
     --end
     --启动敌人的lua控制脚本
     --A_Enemy1.StartProcess()
     
end




