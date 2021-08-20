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
		{count=5,type="A_Enemy2",speed=0.66},
	    {count=5,type="A_Enemy1",speed=0.5},
		{count=5,type="A_Enemy2",speed=1}
	},
	--当前关卡可用炮塔的信息
	turret={
		"DefenseA","DefenseB","DefenseC"
	},
	turretAttributes={
		["DefenseA"]={cost=70,damage=30,Bullet="DeABullet",speed=5,BulletattackRateTime=2,ViewDistance=6},
        ["DefenseB"]={cost=80,damage=10,Bullet="DeBBullet",speed=10,BulletattackRateTime=0.25,ViewDistance=3},
        ["DefenseC"]={cost=90,damage=10,Bullet="DeCBullet",speed=10,BulletattackRateTime=30,ViewDistance=4}
	},
	--不同类型敌人的属性
	enemyAttributes={
		["A_Enemy1"]={Hp=300},
		["A_Enemy2"]={Hp=300}
	},
	--同波次敌人生成间隔
	EnemyRateTime=1.5,
	--波次产生间隔
	WaveRateTime=5,

	--敌人生成位置
	enemySpawmerPosition="StartPosition_levelOne",
	--敌人总数
	AllenemyCounts=15
}
------------------第二关敌人数据--------------------
A_LevelSettings.Level_Two={
   --敌人波次信息
	enemy={
		{count=5,type="A_Enemy2",speed=0.66},
	    {count=5,type="A_Enemy1",speed=0.5},
		{count=5,type="A_Enemy2",speed=1}
	},
	--当前关卡可用炮塔的信息
	turret={
		"DefenseA","DefenseB","DefenseC"
	},
	turretAttributes={
		["DefenseA"]={cost=70,damage=30,Bullet="DeABullet",speed=5,BulletattackRateTime=2,ViewDistance=6},
        ["DefenseB"]={cost=80,damage=10,Bullet="DeBBullet",speed=10,BulletattackRateTime=0.25,ViewDistance=3},
        ["DefenseC"]={cost=90,damage=10,Bullet="DeCBullet",speed=10,BulletattackRateTime=30,ViewDistance=4}
	},
	--不同类型敌人的属性
	enemyAttributes={
		["A_Enemy1"]={Hp=300},
		["A_Enemy2"]={Hp=300}
	},
	--同波次敌人生成间隔
	EnemyRateTime=1.5,
	--波次产生间隔
	WaveRateTime=5,

	--敌人生成位置
	enemySpawmerPosition="StartPosition_levelTwo",
	--敌人总数
	AllenemyCounts=15
}

------------------第三关敌人数据--------------------