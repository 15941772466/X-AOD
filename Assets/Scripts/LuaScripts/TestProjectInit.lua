
TestProjectInit={}
local this=TestProjectInit

-------------UI控制-----------------
function TestProjectInit.Init()
    --导入引入项目中所有的视图层脚本
    this.ImportAllViews()
end




--导入引入项目中所有的视图层脚本
function TestProjectInit.ImportAllViews()

    -- for i=1,#ViewNames do
        
    -- end

    --UI框架视图层
    for i = 1, #TViewNames do
        package.loaded[tostring(TViewNames[i])] = nil
        require(tostring(TViewNames[i]))
    end
    --游戏场景视图层
    for i=1, #A_ViewNames do
        package.loaded[tostring(A_ViewNames[i])] = nil
        require(tostring(A_ViewNames[i]))
    end
    print("导入视图层脚本成功")
end
















