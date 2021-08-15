---
--- “lua框架”定义所有的常量与“枚举”（表）
---
---

--项目中用到的控制层脚本名称
-- TCtrlName={
--           DefenseListCtr="DefenseListCtr"
--          }
--项目中用到的视图层脚本名称
TViewNames={
            "DefenseListUIForm"
}

-----------------游戏内的常量定义--------------------
--游戏中需要的控制层脚本
CtrlName={
    A_EnemySpawnerCtrl="A_EnemySpawnerCtrl",
    A_BuildManagerCtrl="A_A_BuildManagerCtrl",
    A_MapCubeCtrl="A_MapCubeCtrl",
    A_TurretShootCtrl="A_TurretShootCtrl",
    A_BulletCtrl="A_BulletCtrl"
}
--视图层脚本
A_ViewNames={
    "A_Enemy1","DefenseA"
}

--引入Unity内置的类型
WWW=CS.UnityEngine.WWW
GameObject=CS.UnityEngine.GameObject
CSU=CS.UnityEngine
--游戏场景CS工具类
GameTool=CS.GameTools.A_GameHelper