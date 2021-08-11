--建造管理类
require("TestSysDefine")

A_BuildManagerCtrl={}
local this=A_BuildManagerCtrl
--地面列表
GroundData={}
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

--一些本地变量
-- local ray=CSU.Ray
function A_BuildManagerCtrl.Awake()
   --记录地面信息
   --ReadGround()
end

function A_BuildManagerCtrl.Start()
    print("开始处理建造逻辑")    
    --调用添加监听函数 
    AddListener(list)

end



--初始化所有地面位置为无炮塔，未升级
function ReadGround()
   local  ground=CSU.GameObject.Find("CubeManager")
   for i,child in pairs(ground) do
       GroundData[child.name]={preturret=nil,preturrettype=nil,isUpgraded=false}
   end
end

--根据实际UI中炮塔的数量与类型添加监听事件
function AddListener(UIobj)
   --存入所有炮塔的Button
   for i,child in pairs(UIobj) do
    -- this.BtnA=transform:Find("DefenseA")--返回transform
    -- this.BtnA=this.BtnA:GetComponent("UnityEngine.UI.Button") --返回Button类型
    -- this.BtnA.onClick:AddListener(this.ProcessBtnA)
          TurretUIList[i]=child:GetComponent("CSU.UI.Button")
          print(TurretUIList[i])
   end
   --添加事件监听
   for i,listner in pairs(TurretUIList) do
      TurretUIList[i].onClick:AddListener(ListenerProcess(i))
   end
end

function ListenerProcess(i)
   SelectedTurret=TurretUIList[i].name
   print(SelectedTurret)
end

-----------检测点击事件------------------------
function A_BuildManagerCtrl.Update()
   print("建造方法")
   if(CSU.Input.GetMouseButtonDown(0)) then
      print("检测到鼠标点击")
      --打出从摄像机到鼠标点击位置的射线
      local ray=CSU.Camera.main:ScreenPointToRay(CSU.Input.mousePosition)
      print(ray)
      --存储碰撞信息
      local hit=CSU.RaycastHit
      --是否与地图产生碰撞
      local isCollider=CSU.Physics.Raycast(ray, 1000, CSU.LayerMask.GetMask("Ground"))
      print(isCollider)
   end
end
