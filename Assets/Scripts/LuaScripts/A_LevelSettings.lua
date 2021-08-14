--游戏关卡的数据管理

A_LevelSettings={}
local this=A_LevelSettings

function A_LevelSettings.GetInstance()
    return this
end

-------------------第一关-------------------
A_LevelSettings.Level_One={
	enemy={
		WaveOne={count=4,type="A_Enemy1",speed=0.3},
	    WaveTwo={count=5,type="A_Enemy1",speed=0.5}
	},
	turret={
		"DefenseA","DefenseB","DefenseC"
	},
	turretAttributes={
		["DefenseA"]={cost=70,damage=15},
        ["DefenseB"]={cost=80,damage=20},
        ["DefenseC"]={cost=90,damage=25}
	},
	enemyAttributes={
		["A_Enemy1"]={Hp=150}
	},
	waveCount=5
}
------------------第二关敌人数据--------------------
A_LevelSettings.Level_Two={
    enemy={
		-- WaveOne={count=4,type="A_Enemy1",speed=0.3,hp=150},
	    -- WaveTwo={count=5,type="A_Enemy1",speed=0.5,hp=200}
	},
	turret={
		--"DefenseB","DefenseC"
	}
}

------------------第三关敌人数据--------------------