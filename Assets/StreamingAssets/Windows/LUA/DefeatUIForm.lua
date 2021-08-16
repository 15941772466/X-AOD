---
--- 失败窗口  UI窗体视图层脚本
---

DefeatUIForm = {}
local this = DefeatUIForm


local UI_Manager=CS.UIFW.UIManager
local uiManager=UI_Manager.GetInstance()

local Lua_Helper=CS.LuaFramework.LuaHelper 
local luaHelper=Lua_Helper.GetInstance()

local transform
local gameobject

--得到实例
function DefeatUIForm.GetInstance()
    return this
 end

function DefeatUIForm.Awake(obj)
    print("------- DefeatUIForm.Awake  -----------");
    gameobject=obj
    transform=obj.transform
end

function DefeatUIForm.Start(obj)
    this.InitView()
end

function DefeatUIForm.InitView()
    --重新开始
    this.PlayNormalBtn=transform:Find("Image/Restart"):GetComponent("UnityEngine.UI.Button") 
    this.PlayNormalBtn.onClick:AddListener(this.ProcessRestart)

    --返回游戏大厅
    this.PlayNormalBtn=transform:Find("Image/Back"):GetComponent("UnityEngine.UI.Button") 
    this.PlayNormalBtn.onClick:AddListener(this.ProcessBackHallBtn)

end

function DefeatUIForm.ProcessRestart()  --选择关卡
    print("执行到 ProcessRestart")  
    --找到当前场景游戏开始节点
    --？？？
end


function DefeatUIForm.ProcessBackHallBtn()
    print("执行到 ProcessBackHallBtn")  
    uiManager:CloseUIForms("DefeatUIForm")
    uiManager:ShowUIForms("HeroInfoUIForm")
    uiManager:ShowUIForms("MainCityUIForm")
end

