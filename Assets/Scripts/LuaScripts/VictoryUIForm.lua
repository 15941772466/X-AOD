---
--- 胜利窗口  UI窗体视图层脚本
---

VictoryUIForm = {}
local this = VictoryUIForm


local UI_Manager=CS.UIFW.UIManager
local uiManager=UI_Manager.GetInstance()

local Lua_Helper=CS.LuaFramework.LuaHelper 
local luaHelper=Lua_Helper.GetInstance()

local transform
local gameobject

--得到实例
function VictoryUIForm.GetInstance()
    return this
 end

function VictoryUIForm.Awake(obj)
    print("------- VictoryUIForm.Awake  -----------");
    gameobject=obj
    transform=obj.transform
end

function VictoryUIForm.Start(obj)
    this.InitView()
end

function VictoryUIForm.InitView()
    --选择关卡
    this.PlayNormalBtn=transform:Find("Image/SelectLevel"):GetComponent("UnityEngine.UI.Button") 
    this.PlayNormalBtn.onClick:AddListener(this.ProcessSelectLevel)


    --返回游戏大厅
    this.PlayNormalBtn=transform:Find("Image/Back"):GetComponent("UnityEngine.UI.Button") 
    this.PlayNormalBtn.onClick:AddListener(this.ProcessBackHallBtn)

end

function VictoryUIForm.ProcessSelectLevel()  --选择关卡
    print("执行到 ProcessSelectLevel")  
    uiManager:ShowUIForms("LevelsUIForm")
    CS.UnityEngine.SceneManagement.SceneManager.LoadScene("GameHall");
end


function VictoryUIForm.ProcessBackHallBtn()
    print("执行到 ProcessBackHallBtn")  
    uiManager:CloseUIForms("VictoryUIForm")
    uiManager:ShowUIForms("HeroInfoUIForm")
    uiManager:ShowUIForms("MainCityUIForm")
end

