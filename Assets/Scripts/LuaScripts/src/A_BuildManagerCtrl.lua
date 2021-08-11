--建造管理类

----------------引用脚本-----------------------
require("TestSysDefine")
require("A_LevelSettings")

--模拟类
A_BuildManagerCtrl={}
local this=A_BuildManagerCtrl

--调用DefenseManager脚本
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()
--调用游戏工具类
local tool=GameTool.GetInstance()
-------------------建造信息----------------------------
--获取关卡信息
local levelData=A_LevelSettings.GetInstance()
--地面列表
GroundData={}
--炮塔列表
local TurretUIList={}
local GroundDatatmp={}
--监听函数列表
local ListenerList={}
--被选中的炮塔
local SelectedTurret=nil

--找到Canvas
local  UIobj=CSU.GameObject.Find("DefenseListUIForm(Clone)")

--初始化监听函数
ListenerList["DefenseA"]=function () SelectedTurret="DefenseA" print(SelectedTurret) end
ListenerList["DefenseB"]=function () SelectedTurret="DefenseB" print(SelectedTurret) end
ListenerList["DefenseC"]=function () SelectedTurret="DefenseC" print(SelectedTurret) end
ListenerList["DefenseD"]=function () SelectedTurret="DefenseD" print(SelectedTurret) end

function A_BuildManagerCtrl.Awake()
   --记录地面信息
   ReadGround()
end

function A_BuildManagerCtrl.Start(obj)
    print("开始处理建造逻辑")    
    local Level=levelData[obj.tag]
    --调用添加监听函数 
    AddListener(Level.turret)

end

--初始化所有地面位置为无炮塔，未升级
function ReadGround()
   local ground=CSU.GameObject.Find("CubeManager")
   GroundDatatmp=tool:GetChildName(ground,GroundDatatmp)
   for i,child in pairs(GroundDatatmp) do
      GroundData[child]={preturret=nil,preturrettype=nil,isUpgraded=false}
   end
end


--根据实际UI中炮塔的数量与类型添加监听事件
function AddListener(levelDataTurret)

   --存入所有炮塔的Button
   for i,child in pairs(levelDataTurret) do
      TurretUIList[i]=UIobj.transform:Find(child)
      TurretUIList[i]=TurretUIList[i]:GetComponent("UnityEngine.UI.Button") 
   end

   --添加事件监听
   for i,listner in pairs(TurretUIList) do
      print(listner)
      listner.onClick:AddListener(ListenerList[listner.name])
   end
end



-----------检测点击事件------------------------
function A_BuildManagerCtrl.Update()
   --如果检测到鼠标点击且未点击到UI，执行炮塔建造
   local isover=tool:IsOverGameObject()
   --鼠标点击
   if(CSU.Input.GetMouseButtonDown(0)) then
      --不在UI上
      if(isover==false) then
        --是否与地图产生碰撞
        local isCollider=tool:isCollider()
        --存储碰撞信息
        local HitInfro=tool:HitInfro()
        
        --如果点击了砖块
        if(isCollider==true) then
            print("点击到砖块")
            --找到点击的砖块名字
            local cubeName=HitInfro.collider.gameObject.name
            print(cubeName)
        end
      end
   end
end
