--项目入口


--游戏初始化脚本
require("TestProjectInit")
--引入项目常量和“枚举”等
require("TestSysDefine")
--引入游戏控制脚本
require("A_CtrlMgr")

--游戏开始
print("游戏开始")
TestProjectInit.Init()
A_CtrlMgr.Init()

