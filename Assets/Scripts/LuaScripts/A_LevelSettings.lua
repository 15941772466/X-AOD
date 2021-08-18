--游戏关卡的数据管理

A_LevelSettings={}
local this=A_LevelSettings

function A_LevelSettings.GetInstance()
    return this
end

-------------------第一关-------------------
A_LevelSettings.Level_One={
	--敌人波次信息
	enemy={
		WaveOne={count=10,type="A_Enemy1",speed=0.3},
	    WaveTwo={count=5,type="A_Enemy1",speed=0.5}
	},
	--当前关卡可用炮塔的信息
	turret={
		"DefenseA","DefenseB","DefenseC"
	},
	turretAttributes={
		["DefenseA"]={cost=70,damage=40,Bullet="DeABullet",speed=1,BulletattackRateTime=2},
        ["DefenseB"]={cost=80,damage=20,Bullet="DeBBullet",speed=1,BulletattackRateTime=0.25},
        ["DefenseC"]={cost=90,damage=25,Bullet="DeCBullet",speed=1,BulletattackRateTime=30}
	},
	--不同类型敌人的属性
	enemyAttributes={
		["A_Enemy1"]={Hp=150}
	},
	--同波次敌人生成间隔
	EnemyRateTime=1.5,
	--波次产生间隔
	WaveRateTime=5
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