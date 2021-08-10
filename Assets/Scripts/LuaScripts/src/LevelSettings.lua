--游戏关卡的数据管理

LevelSettings={}
local this=LevelSettings

function LevelSettings.GetInstance()
    return this
end

-------------------第一关-------------------
LevelSettings.Level_One={
	WaveOne={count=4,type="A_Enemy1",speed=0.3},
	WaveTwo={count=5,type="A_Enemy1",speed=0.5}
}
-- LevelSettings.levelOne_turret={
--     ""
-- }
------------------第二关敌人数据--------------------