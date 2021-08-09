--敌人生成的数据管理

LevelSettings={}
local this=LevelSettings

function LevelSettings.GetInstance()
    return this
end

-------------------第一关敌人数据-------------------
LevelSettings.levelOne_enemy={
	WaveOne={count=4,type="A_Enemy1",speed=0.5},
	WaveTwo={count=5,type="A_Enemy1",speed=1}
}
------------------第二关敌人数据--------------------