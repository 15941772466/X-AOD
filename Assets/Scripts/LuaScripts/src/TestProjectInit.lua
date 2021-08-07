---
---  “lua框架”项目初始化
---
---   功能：
---      1： 引入项目中所有的视图层脚本
---      2： 通过CtrlMgr.lua （控制层）脚本，来缓存系统中所有其他控制层脚本。
---      3： 提供访问其他控制层脚本的入口函数。
---      4： 调用项目中第一个UI预设控制层脚本。
---
---

--引入控制层管理器脚本
--require("TestCtrlMgr")
TestProjectInit={}
local this=TestProjectInit

-------------UI控制-----------------
function TestProjectInit.Init()
    --导入引入项目中所有的视图层脚本
    this.ImportAllViews()
end




--导入引入项目中所有的视图层脚本
function TestProjectInit.ImportAllViews()
    print("导入视图层脚本成功")
    --UI框架视图层
    for i = 1, #TViewNames do
        require(tostring(TViewNames[i]))
    end
    --游戏场景视图层
    for i=1, #A_ViewNames do
        require(tostring(A_ViewNames[i]))
    end
end
















