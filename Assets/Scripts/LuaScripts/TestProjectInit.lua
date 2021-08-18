
TestProjectInit={}
local this=TestProjectInit

-------------UI控制-----------------
function TestProjectInit.Init()
    --导入引入项目中所有的视图层脚本
    this.ImportAllViews()
    this.ImportAllCtrls()
end




--导入引入项目中所有的视图层脚本
function TestProjectInit.ImportAllViews()
    --UI框架视图层
    for i = 1, #TViewNames do
        package.loaded[TViewNames[i]] = nil
        require(TViewNames[i])
    end
    --游戏场景视图层
    for i=1, #A_ViewNames do
        package.loaded[A_ViewNames[i]] = nil
        require(A_ViewNames[i])
    end
    print("导入视图层脚本成功")
end

function TestProjectInit.ImportAllCtrls()
    for i=1, #A_CtrlNames do
        package.loaded[A_CtrlNames[i]] = nil
        require(A_CtrlNames[i])
    end
end
















