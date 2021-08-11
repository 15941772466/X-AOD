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
local  UIobj=CSU.GameObject.Find("DefenseListUIForm(Clone)")
local list=UIobj.transform:Find("TurretList")

-- function A_BuildManagerCtrl.GetInstance()
-- 	print("拿到炮塔建造管理类实例")
--     return this
-- end

function A_BuildManagerCtrl.Start()
    print("开始处理建造逻辑")
    -- --获取UI与其子物体
    -- local FightUIObj=CSU.GameObject.Find("FightUI")
    -- print(FightUIObj)
    -- local ChildObjPanel=FightUIObj.transform:Find("FightUIPanel/TurretSwitch")
    -- print(ChildObjPanel)
    -- --调用添加监听函数 
    print(UIobj)
    print(list)
    --AddListener(list)

end


--根据实际UI中炮塔的数量与类型添加监听事件
function AddListener(UIobj)
   --存入所有炮塔的Button
   for i,child in pairs(UIobj) do
    -- this.BtnA=transform:Find("DefenseA")--返回transform
    -- this.BtnA=this.BtnA:GetComponent("UnityEngine.UI.Button") --返回Button类型
    -- this.BtnA.onClick:AddListener(this.ProcessBtnA)
          TurretUIList[i]=child.gameObject:GetComponent("CSU.UI.Button")
          print(TurretUIList[i])
   end
   --添加事件监听
   for i,listner in pairs(TurretUIList) do
      TurretUIList[i].onClick:AddListener(ListenerProcess(i))
   end
end

function ListenerProcess(i)
   SelectedTurret=TurretUIList[i].name
end

-----------检测点击事件------------------------
function A_BuildManagerCtrl.Update()
   print("建造方法")
   if(CSU.Input.GetMouseButtonDown(0)) then
      print("检测到鼠标点击")
   end
end
