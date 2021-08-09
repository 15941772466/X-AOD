--建造管理类
require("TestSysDefine")

A_BuildManagerCtrl={}
local this=A_BuildManagerCtrl

--炮塔列表
local TurretUIList={}
--被选中的炮塔
local SelectedTurret=nil
--获取建造UI

-- --调用C#的ABFW框架上的DefenseManager
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()
--找到Canvas
local  UIobj=CSU.GameObject.Find("DefenseListUIForm")


function A_BuildManagerCtrl.GetInstance()
	print("拿到炮塔建造管理类实例")
    return this
end

function A_BuildManagerCtrl.StartProcess()
    print("开始处理建造逻辑")
    -- --获取UI与其子物体
    -- local FightUIObj=CSU.GameObject.Find("FightUI")
    -- print(FightUIObj)
    -- local ChildObjPanel=FightUIObj.transform:Find("FightUIPanel/TurretSwitch")
    -- print(ChildObjPanel)
    -- --调用添加监听函数
    print(UIobj)
    --AddListener(UIobj)

end


--根据实际UI中炮塔的数量与类型添加监听事件
-- function AddListener(ChildObjPanel)
--    --存入所有炮塔的Button
--    for i,child in pairs(ChildObjPanel) do
--           TurretUIList[i]=child.gameObject --:GetComponent(typeof("CSU.UI.Button"))
--           print(TurretUIList[i])
--    end
--    --添加事件监听
--    for i,listner in pairs(TurretUIList) do
--       TurretUIList[i].onClick:AddListener(ListenerProcess(i))
--    end
-- end

-- function ListenerProcess(i)
--    SelectedTurret=TurretUIList[i].name
-- end

