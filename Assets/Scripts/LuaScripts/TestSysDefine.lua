-----------------游戏内的常量定义--------------------
--游戏中需要的控制层脚本
CtrlName={
    A_EnemySpawnerCtrl="A_EnemySpawnerCtrl",
    A_BuildManagerCtrl="A_BuildManagerCtrl",
    A_MapCubeCtrl="A_MapCubeCtrl",
    A_TurretShootCtrl="A_TurretShootCtrl",
    A_BulletCtrl="A_BulletCtrl"
}
--视图层脚本
TViewNames={
    "DefenseListUIForm"
}
A_CtrlNames={
    "A_BaseList",
    "A_LevelSettings",
    "A_SettlementCtrl",
    "A_EnemySpawnerCtrl",           
    "A_BuildManagerCtrl",

}
A_ViewNames={
    "A_TurretManager",
    "A_BulletManager",
    "A_EnemyManager",

    "A_Turret",
    "A_BulletAB",
    "A_Enemy",
    
    "DefeatUIForm",
}

--引入Unity内置的类型
WWW=CS.UnityEngine.WWW
GameObject=CS.UnityEngine.GameObject
CSU=CS.UnityEngine
--游戏场景CS工具类
GameTool=CS.GameTools.A_GameHelper