--建造管理类

----------------引用脚本-----------------------
require("TestSysDefine")
require("A_LevelSettings")
require("TurretManager")

--模拟类
A_BuildManagerCtrl={}
local this=A_BuildManagerCtrl

--调用DefenseManager脚本
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()
--调用游戏工具类
local tool=GameTool.GetInstance()
-------------------建造信息----------------------------
--玩家金币
local Money=1500
--获取关卡信息
local levelData=A_LevelSettings.GetInstance()
--当前关卡
local Level
--地面列表
GroundData={}
--炮塔列表
local TurretUIList={}
local GroundDatatmp={}
--监听函数列表
local ListenerList={}
--被选中的炮塔
local SelectedTurret=nil
--被点击的地面
local cubeName
--找到Canvas
local  UIobj=CSU.GameObject.Find("DefenseListUIForm(Clone)")

local index = 0


--初始化监听函数
ListenerList["DefenseA"]=function () SelectedTurret="DefenseA" end
ListenerList["DefenseB"]=function () SelectedTurret="DefenseB" end
ListenerList["DefenseC"]=function () SelectedTurret="DefenseC" end
ListenerList["DefenseD"]=function () SelectedTurret="DefenseD" end

function A_BuildManagerCtrl.Awake()
   --记录地面信息
   ReadGround()
end

function A_BuildManagerCtrl.Start(obj)
    print("开始处理建造逻辑")    
    --当前关卡信息
    Level=levelData[obj.tag]
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

   --根据关卡数据检索UI上对应的按钮
   for i,child in pairs(levelDataTurret) do
      TurretUIList[i]=UIobj.transform:Find(child)
      TurretUIList[i]=TurretUIList[i]:GetComponent("UnityEngine.UI.Button") 
   end

   --添加按钮事件监听
   for i,listner in pairs(TurretUIList) do
      listner.onClick:AddListener(ListenerList[listner.name])
   end
   print("按钮事件监听添加成功")
end



-----------检测玩家操作------------------------
function A_BuildManagerCtrl.Update()
   --如果检测到鼠标点击且未点击到UI，执行炮塔建造
   local isover=tool:IsOverGameObject()
   --鼠标点击且不在UI上

   if(CSU.Input.GetMouseButtonDown(0) and isover==false) then
        --是否与地图产生碰撞
        local isCollider=tool:isCollider()
        --存储碰撞信息
        local HitInfro=tool:HitInfro()
        --如果点击了砖块
        if(isCollider==true and HitInfro.collider.gameObject.layer==8) then
            --找到点击的砖块名字
            cubeName=HitInfro.collider.gameObject.name
            print("点击到砖块："..cubeName)

            --如果此砖块上无炮塔，且已经选择了一个炮塔
            if(GroundData[cubeName].preturret==nil and SelectedTurret~=nil) then
               
               --检测金币余额
               if(Money>=Level.turretAttributes[SelectedTurret].cost) then
                  --扣钱qwq
                  this.ChanageMoney(Level.turretAttributes[SelectedTurret].cost)
                  --建造炮塔
                  this.BuildTurret(SelectedTurret,cubeName) 
               else 
                  --没钱了你
                  print("没钱了！！")
               end
               print("选择的炮塔："..SelectedTurret.."   价格："..Level.turretAttributes[SelectedTurret].cost.."剩余金币"..Money)
            --已经有炮塔
            elseif(GroundData[cubeName].preturret~=nil) then

            end
        end
   end
end

--金币更改
function A_BuildManagerCtrl.ChanageMoney(changeMoney)
   Money=Money-changeMoney
end

--炮塔建造
function A_BuildManagerCtrl.BuildTurret(SelectedTurret,cubeName)
   --找到选中的地面
   local cube =CSU.GameObject.Find(cubeName)
   --获取炮塔要生成的位置
   local position=cube.transform.position
   --加载炮塔预制体
   local tmpObj=abDTObj:PrefabAB(SelectedTurret)
   --生成并记录
   GroundData[cubeName].preturret=CSU.GameObject.Instantiate(tmpObj)
   --炮塔上移
   GroundData[cubeName].preturret.transform.position=tool:UpPosition(position)
   --当前cube上的炮塔类型
   GroundData[cubeName].preturrettype=SelectedTurret
   --实例化炮塔类
   local TurretObj=Turret:New(GroundData[cubeName].preturret)
   index = index + 1
   --存入炮塔列表
   TurretManager.DefenseList[index] = TurretObj
   

end



