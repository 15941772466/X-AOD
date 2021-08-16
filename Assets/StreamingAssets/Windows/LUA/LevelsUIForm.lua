---
--- 选择关卡窗口  UI窗体视图层脚本
---

LevelsUIForm = {}
local this = LevelsUIForm


local UI_Manager=CS.UIFW.UIManager
local uiManager=UI_Manager.GetInstance()

local Lua_Helper=CS.LuaFramework.LuaHelper 
local luaHelper=Lua_Helper.GetInstance()

local transform
local gameobject

--得到实例
function LevelsUIForm.GetInstance()
    return this
 end

function LevelsUIForm.Awake(obj)
    print("------- LevelsUIForm.Awake  -----------");
    gameobject=obj
    transform=obj.transform
end

function LevelsUIForm.Start(obj)
    this.InitView()
end

function LevelsUIForm.InitView()
    --第一关
    this.PlayNormalBtn=transform:Find("Panel/Show/Levels/Level_One"):GetComponent("UnityEngine.UI.Button") 
    this.PlayNormalBtn.onClick:AddListener(this.ProcessLevel_One)


    --返回游戏大厅
    this.PlayNormalBtn=transform:Find("Panel/Close"):GetComponent("UnityEngine.UI.Button") 
    this.PlayNormalBtn.onClick:AddListener(this.ProcessBackHallBtn)

end

function LevelsUIForm.ProcessLevel_One()
   
    print("执行到 ProcessLevel_One")  --开始关卡1游戏
    --解场景包
    
    luaHelper:DoString("require 'TestStartGame'")
    uiManager:ShowUIForms("GameInfoUIForm")
    uiManager:ShowUIForms("DefenseListUIForm")

    CS.UnityEngine.SceneManagement.SceneManager.LoadScene("Level_One");
end



function LevelsUIForm.ProcessBackHallBtn()
    print("执行到 ProcessBackHallBtn")  
    uiManager:ShowUIForms("MainCityUIForm")
    uiManager:ShowUIForms("HeroInfoUIForm")
end

