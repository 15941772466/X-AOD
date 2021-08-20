--敌人生成管理类

----------------引用脚本-----------------------
-- --怪物生成逻辑
-- require("TestSysDefine")
-- --获取关卡数据
-- require("A_LevelSettings")
-- --游戏结算脚本
-- require("A_SettlementCtrl")


--模拟类
A_EnemySpawnerCtrl={
   --活着的敌人,用于判断游戏胜利与否
   EnemyAlive=nil,
   --生成的敌人列表
   EnemyListSpawnered={},
   --已经生成的敌人数量
   Enemycount=nil
}
local this=A_EnemySpawnerCtrl

--活着的敌人,用于判断游戏胜利与否
this.EnemyAlive=0
--生成的敌人列表
this.EnemyListSpawnered={}
--已经生成的敌人数量
this.Enemycount=0

--调用游戏工具类
local tool=GameTool.GetInstance()

----------------关于敌人的数据等------------------
--拿到敌人加载的cs脚本
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()
--拿到敌人数据的实例
local levelData=A_LevelSettings.GetInstance()
--敌人列表

--存放敌人预制体
local tempObj={}
--存放敌人血条UI
local tempSlider
--计数参数
local Index=0
--已经等待时间
local timer
--生成间隔
local RateTime
--要生成的敌人数量
local EnemyCount
--用于判断是否第一次等于0
local IsFirstEqualZero=true
--敌人生成位置
local EnemyPosition

--关卡信息
local Level
--当前关卡波次
local levelWave={}

--敌人结算脚本的实例
local settlementCtrl=A_SettlementCtrl.GetInstance()

function A_EnemySpawnerCtrl.GetInstance()
	print("进入敌人生成管理类")
    return this
end

--------------------------------------敌人生成逻辑-------------------------------------------
function A_EnemySpawnerCtrl.Awake()

end

function A_EnemySpawnerCtrl.Start(obj)
   --------------------------------初始化、清空------------------------------
   --活着的敌人,用于判断游戏胜利与否
   this.EnemyAlive=0
   --生成的敌人列表
   this.EnemyListSpawnered={}
   --已经生成的敌人数量
   this.Enemycount=0
   --敌人生成位置
   this.EnemyPosition=nil


   local WaveCount=0
   --敌人出生地
   EnemyPosition=CSU.GameObject.Find("SatrtPosition").transform.position
   --获取当前关卡
   Level=levelData[obj.tag]
   --间隔时间
   RateTime=Level.EnemyRateTime
   --已经等待时间
   timer=0
   --敌人数量
   EnemyCount=Level.enemy.WaveOne.count
   --读取敌人种类进行加载 并读取波次数量
   for i,wave in pairs(Level.enemy) do
      tempObj[wave.type]=abDTObj:PrefabAB(wave.type)
      WaveCount=i
   end
   tempSlider=abDTObj:PrefabAB("Hp")
   --按波数生成敌人
   --this.enemySpawner(Level.enemy)
   --成功加载完所有敌人并全部被消灭，游戏胜利
   --A_SettlementCtrl.Win()

end



function A_EnemySpawnerCtrl.Update()
   --如果没生成完
   if(this.Enemycount<EnemyCount) then
      --等待生成间隔
      timer=timer+CSU.Time.deltaTime
      if(timer>=RateTime) then
         this.ShengCheng()
         timer=0
      end
   end
   --print("A_EnemySpawener106行  场上敌人：  "..this.EnemyAlive.."已经生成的敌人：  "..Enemycount.."需要生成：  "..EnemyCount)

   --如果场上敌人为0且全部生成完
   if this.EnemyAlive==0 and this.Enemycount==EnemyCount then
      A_SettlementCtrl.GetInstance():Win()
   end

end


function A_EnemySpawnerCtrl.ShengCheng()
   local enemyObj=CSU.Object.Instantiate(tempObj[Level.enemy.WaveOne.type],EnemyPosition,CSU.Quaternion.identity)
   local enemySliderCanvas=CSU.Object.Instantiate(tempSlider,EnemyPosition,CSU.Quaternion.identity)
   --存入全局敌人列表
   table.insert(this.EnemyListSpawnered,enemyObj)

   --实例化敌人行为类, 传入对应血条UI，总血量，初始化当前血量,速度
   local EnemyObj=A_Enemy:New(enemyObj,enemySliderCanvas,Level.enemyAttributes[Level.enemy.WaveOne.type].Hp,Level.enemy.WaveOne.speed)
   
   --存入行为类列表
   Index=Index+1
   --存入索引
   EnemyObj.IndexSelf=Index
   --存入敌人Update管理实例列表
   A_EnemyManager.EnemySelfList[Index]=EnemyObj

   --已经生成的敌人数量
   this.Enemycount=this.Enemycount+1
   --当前活着的敌人数量
   this.EnemyAlive=this.EnemyAlive+1
end


--敌人死亡，刷新全局敌人列表
function A_EnemySpawnerCtrl:UpdateALLEnemySpawnered(obj)
   for i=1,this.Enemycount do
      if(this.EnemyListSpawnered[i]==obj) then
         this.EnemyListSpawnered[i]=nil
         break
      end
   end
end




--敌人生成
-- function A_EnemySpawnerCtrl.enemySpawner(LevelDataEnemy)
  
--    for i,wave in pairs(LevelDataEnemy) do
--       -- print(wave.count)
--       for i=1,wave.count do
--          --实例化
--          local enemyObj=CSU.Object.Instantiate(tempObj[wave.type],EnemyPosition,CSU.Quaternion.identity)
--          local enemySliderCanvas=CSU.Object.Instantiate(tempSlider,EnemyPosition,CSU.Quaternion.identity)
--          --传入对应血条UI
--          enemyObj:GetComponent("Enemy"):GetUpcanvas(enemySliderCanvas)
--          --传入对应血量
--          enemyObj:GetComponent("Enemy"):GetHp(Level.enemyAttributes[wave.type].Hp)
--          --设置移动速度
--          enemyObj:GetComponent(typeof(CSU.AI.NavMeshAgent)).speed=wave.speed
--          --实例化敌人行为类
--          local EnemyObj=A_Enemy:New(enemyObj)
--          --存入行为类列表
--          Index=Index+1
--          --存入索引
--          EnemyObj.IndexSelf=Index
--          --存入敌人实例列表
--          A_EnemyManager.EnemySelfList[Index]=EnemyObj
--          local count=0
--          for i,v in pairs(A_EnemyManager.EnemySelfList) do
--             count=i
--          end
--          EnemyCount=EnemyCount+1
         
         
--       end
--       --等待上一波敌人全部被消灭
--   end
-- end
