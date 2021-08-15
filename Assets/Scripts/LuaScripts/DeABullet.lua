--子弹控制管理

require("A_LevelSettings")

DeABullet={
  --获取关卡信息
  levelData=A_LevelSettings.GetInstance(),
  --调用游戏工具类
  tool=GameTool.GetInstance(),
   --当前关卡
  Level,
  --子弹伤害
  damage,
  --子弹速度
  speed=30,
  --子弹目标
  Target
}

DeABullet.__index = DeABullet
function DeABullet:New()
   -- body
   local temp = {}
   setmetatable(temp,DeABullet)
   return temp
end

function DeABullet.Start(obj)
	local tmp=CSU.GameObject.Find("A_GameManager")
	--当前关卡
    Level=levelData[tmp.tag]
    --子弹伤害
    damage=Level.turretAttributes["DefenseA"].damage
end

function DeABullet.Update(obj)
    -- if(target==nil) then
    -- 	this.Die()
    -- 	return
    -- end
    obj.transform.LookAt(target)
    tool:Translate(obj,speed)
end

function DeABullet.GetTarget(target)
    Target=target
end

function DeABullet.Die()
   
end