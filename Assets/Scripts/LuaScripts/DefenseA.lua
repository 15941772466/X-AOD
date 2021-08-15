
--获取怪物数据
require("A_LevelSettings")


--设置单例
DefenseA={}
local this=DefenseA

--调用游戏工具类
local tool=GameTool.GetInstance()

--视野范围内敌人列表
local EnemyList={}
--敌人列表Count
local ListCount=0
--攻击间隔
local attackRateTime=1
--已经等待时间
local timer

--子弹
local Bullet
--开火位置
local FirePosition
--头部炮管
local Head

function DefenseA.Start(obj)
   --初始化等待时间
   timer=attackRateTime
   --得到头部
   Head=obj.transform:Find("Head")
end

function DefenseA.Update()
   --更新敌人列表数量
   --this.UpdateListCount()
   --如果附近有敌人
   if(ListCount>0 and EnemyList[1]~=nil) then
   	  --找到目标敌人
      local targetPosition=EnemyList[1].transform.position
      --固定y轴
      targetPosition.y=Head.position.y
      --朝向敌人
      tool:LookAt(Head,targetPosition)
   end
   --如果附近有敌人且冷却时间已过
   timer=timer+CSU.Time.deltaTime
   if(ListCount>0 and timer>=attackRateTime) then
   	  --发动攻击
   	  this.Attack()
   	  --等待时间置零
   	  timer=0
   end
end


function DefenseA.Attack()
   --print("Biu~")
end

function DefenseA.UpdateListCount()
    local counttmp=0
	for i,child in pairs(EnemyList) do
       counttmp=i+1
	end
	ListCount=counttmp
end


-----------------更新视野内敌人列表----------------------
--进入视野，添加
function DefenseA.OnTriggerEnter(collider)
   table.insert(EnemyList,collider.gameObject)
   ListCount=ListCount+1
   --print("进入视野"..ListCount)
end
--推出视野，删除
function DefenseA.OnTriggerExit(collider)
   --EnemyList[collider.gameObject]=nil
   for k,v in pairs(EnemyList) do
      if(v==collider.gameObject) then
         table.remove(EnemyList,k)
         break
      end
   end
   ListCount=ListCount-1
   --print("退出视野"..ListCount)
end