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
		{count=5,type="A_Enemy1",speed=0.3},
		{count=5,type="A_Enemy2",speed=0.6},
		{count=5,type="A_Enemy1",speed=0.3}
	},
	--当前关卡可用炮塔的信息
	turret={
		"DefenseA","DefenseB","DefenseC"
	},
	--炮塔的属性：     价格       升级价格      伤害       子弹类型         子弹速度     攻击频率             视野范围            升级后属性...
	turretAttributes={
		["DefenseA"]={cost=70,UpgradeCost=50,damage=30,Bullet="DeABullet",speed=5,BulletattackRateTime=2,ViewDistance=6,UpgradeAttributes={damage=40,speed=7,BulletattackRateTime=1,ViewDistance=8}},
		["DefenseB"]={cost=80,UpgradeCost=50,damage=10,Bullet="DeBBullet",speed=10,BulletattackRateTime=0.4,ViewDistance=3,UpgradeAttributes={damage=20,speed=12,BulletattackRateTime=0.25,ViewDistance=5}},
		["DefenseC"]={cost=90,UpgradeCost=50,damage=10,Bullet="DeCBullet",speed=10,BulletattackRateTime=30,ViewDistance=4,UpgradeAttributes={damage=15,speed=12,BulletattackRateTime=20,ViewDistance=6}}
	},
	--不同类型敌人的属性: 血量
	enemyAttributes={
		["A_Enemy1"]={Hp=300},
		["A_Enemy2"]={Hp=200}
	},
	--同波次敌人生成间隔
	EnemyRateTime=1.5,
	--波次产生间隔
	WaveRateTime=5,

	--敌人生成位置
	enemySpawmerPosition="StartPosition_levelOne",
	--敌人总数
	AllenemyCounts=20
}
------------------第二关敌人数据--------------------
A_LevelSettings.Level_Two={
   --敌人波次信息
	enemy={
		{count=5,type="A_Enemy2",speed=0.66},
	    {count=5,type="A_Enemy1",speed=0.3},
		{count=5,type="A_Enemy2",speed=0.6},
		{count=5,type="A_Enemy1",speed=0.3}
	},
	--当前关卡可用炮塔的信息
	turret={
		"DefenseA","DefenseB","DefenseC"
	},
	--炮塔的属性：     价格       升级价格      伤害       子弹类型         子弹速度     攻击频率             视野范围            升级后属性...
 	turretAttributes={
		["DefenseA"]={cost=70,UpgradeCost=50,damage=30,Bullet="DeABullet",speed=5,BulletattackRateTime=2,ViewDistance=6,UpgradeAttributes={damage=40,speed=7,BulletattackRateTime=1,ViewDistance=8}},
        ["DefenseB"]={cost=80,UpgradeCost=50,damage=10,Bullet="DeBBullet",speed=10,BulletattackRateTime=0.4,ViewDistance=3,UpgradeAttributes={damage=20,speed=12,BulletattackRateTime=0.25,ViewDistance=5}},
        ["DefenseC"]={cost=90,UpgradeCost=50,damage=10,Bullet="DeCBullet",speed=10,BulletattackRateTime=30,ViewDistance=4,UpgradeAttributes={damage=15,speed=12,BulletattackRateTime=20,ViewDistance=6}}
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
	AllenemyCounts=20
}

------------------第三关敌人数据--------------------

A_LevelSettings.Level_Three={
	--敌人波次信息
	enemy={
		{count=5,type="A_Enemy2",speed=0.66},
	    {count=5,type="A_Enemy1",speed=0.3},
		{count=5,type="A_Enemy2",speed=0.6},
		{count=5,type="A_Enemy1",speed=0.3}
	},
	--当前关卡可用炮塔的信息
	turret={
		"DefenseA","DefenseB","DefenseC"
	},
	turretAttributes={
		["DefenseA"]={cost=70,damage=30,Bullet="DeABullet",speed=5,BulletattackRateTime=2,ViewDistance=6,Effect="DeA_Effect"},
        ["DefenseB"]={cost=80,damage=10,Bullet="DeBBullet",speed=10,BulletattackRateTime=0.25,ViewDistance=3,Effect="DeB_Effect"},
        ["DefenseC"]={cost=90,damage=10,Bullet="DeCBullet",speed=10,BulletattackRateTime=30,ViewDistance=4,Effect="DeC_Effect"}
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
	enemySpawmerPosition="StartPosition_levelThree",
	--敌人总数
	AllenemyCounts=20
}