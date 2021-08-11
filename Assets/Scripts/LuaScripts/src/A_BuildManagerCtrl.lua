--建造管理类
require("TestSysDefine")
require("A_LevelSettings")


-- --调用C#的ABFW框架上的DefenseManager
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()
--获取关卡信息
local levelData=A_LevelSettings.GetInstance()

--单例
A_BuildManagerCtrl={}
local this=A_BuildManagerCtrl

--地面列表
GroundData={}
--炮塔列表
local TurretUIList={}
--监听函数列表
local ListenerList={}
--被选中的炮塔
local SelectedTurret=nil




--找到Canvas
local  UIobj=CSU.GameObject.Find("DefenseListUIForm(Clone)")



function A_BuildManagerCtrl.Awake()
   --记录地面信息
   --ReadGround()
end

function A_BuildManagerCtrl.Start(obj)
    print("开始处理建造逻辑")    
    local Level=levelData[obj.tag]
    print(Level)
    --调用添加监听函数 
    AddListener(Level.turret)

end

--初始化监听函数
ListenerList["DefenseA"]=function () SelectedTurret="DefenseA" print(SelectedTurret) end
ListenerList["DefenseB"]=function () SelectedTurret="DefenseB" print(SelectedTurret) end
ListenerList["DefenseC"]=function () SelectedTurret="DefenseC" print(SelectedTurret) end
ListenerList["DefenseD"]=function () SelectedTurret="DefenseD" print(SelectedTurret) end



--初始化所有地面位置为无炮塔，未升级
function ReadGround()
   local  ground=CSU.GameObject.Find("CubeManager")
   for i,child in pairs(ground) do
       GroundData[child.name]={preturret=nil,preturrettype=nil,isUpgraded=false}
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

function ListenerList.ListenerProcess()
   --SelectedTurret=TurretUIList[i].name
   print("SelectedTurret")
end

-----------检测点击事件------------------------
function A_BuildManagerCtrl.Update()
   --如果检测到鼠标点击且未点击到UI，执行炮塔建造
   if(CSU.Input.GetMouseButtonDown(0)) then
      --if(CSU.EventSystems.EventSystem.current.IsPointerOverGameObject()==false) then
        print("检测到鼠标点击")
        --打出从摄像机到鼠标点击位置的射线
        local ray=CSU.Camera.main:ScreenPointToRay(CSU.Input.mousePosition)
        print(ray)
        --存储碰撞信息
        local hit=CSU.RaycastHit
        --是否与地图产生碰撞
        local isCollider=CSU.Physics.Raycast(ray, out hit,1000, CSU.LayerMask.GetMask("Ground"))
        print(isCollider)
      --end
   end
end
