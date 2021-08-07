--控制层管理器
--功能：    
--    1.缓存访问所有控制层脚本
--    2.提供访问项目中所有控制层脚本的入口函数

--加载敌人生成控制类
require("A_EnemySpawnerCtrl")
require("A_BuildManagerCtrl")



A_CtrlMgr={}
local this=A_CtrlMgr
--定义控制器列表
local ctrlList={}

function A_CtrlMgr.Init()
	print("加载敌人生成管理脚本")
	local EneObj=A_EnemySpawnerCtrl.GetInstance() --得到敌人生成管理类的实例
	EneObj.StartProcess()
	print("加载炮塔生成管理脚本")
	local BuildObj=A_BuildManagerCtrl.GetInstance() --得到建造管理类的实例
    BuildObj.StartProcess()
end

----获取控制器Lua脚本
-- function A_CtrlMgr.GetCtrlInstance(ctrlName)
-- 	return ctrlList[ctrlName]
-- end

-- --获取控制器lua的实例，且调用SrartProcess函数
-- function A_CtrlMgr.StartProcess(ctrlName)
-- 	local crlObj=A_CtrlMgr.GetCtrlInstance(ctrlName)
-- 	if(ctrlName~=nil) then
-- 		ctrlObj:StartProcess()
-- 	end
-- end


--赢得战斗
function Win()

end
--战败
function Failed()

end
--重玩
function Retry()

end
--返回菜单
function ButtonMenu()

end

