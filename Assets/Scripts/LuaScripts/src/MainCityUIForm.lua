---
--- 主视图窗口  UI窗体视图层脚本
---

MainCityUIForm = {}
local this = MainCityUIForm


local UI_Manager=CS.SUIFW.UIManager
local uiManager=UI_Manager.GetInstance()

local Lua_Helper=CS.LuaFramework.LuaHelper 
local luaHelper=Lua_Helper.GetInstance()

local transform
local gameobject

--得到实例
function MainCityUIForm.GetInstance()
    return this
 end

function MainCityUIForm.Awake(obj)
    print("------- MainCityUIForm.Awake  -----------");
    gameobject=obj
    transform=obj.transform
end

function MainCityUIForm.Start(obj)
    this.InitView()
end

function MainCityUIForm.InitView()
    --查找UI中按钮
    this.PlayNormalBtn=transform:Find("PlayNormal")--返回transform
    this.PlayNormalBtn=this.PlayNormalBtn:GetComponent("UnityEngine.UI.Button") --返回Button类型
    this.PlayNormalBtn.onClick:AddListener(this.ProcessPlayNormal)

    this.MarketBtn=transform:Find("BtnMarket")--返回transform
    this.MarketBtn=this.MarketBtn:GetComponent("UnityEngine.UI.Button") --返回Button类型
    this.MarketBtn.onClick:AddListener(this.ProcessMarket)

    this.EmallBtn=transform:Find("BtnEmall")--返回transform
    this.EmallBtn=this.EmallBtn:GetComponent("UnityEngine.UI.Button") --返回Button类型
    this.EmallBtn.onClick:AddListener(this.ProcessEmallBtn)
end

function MainCityUIForm.ProcessPlayNormal()
   
    print("执行到 ProcessPlayNormal")  --开始游戏
    --解场景包
    
    luaHelper:DoString("require 'TestStartGame'")
    uiManager:ShowUIForms("GameInfoUIForm")
    uiManager:ShowUIForms("DefenseListUIForm")

    CS.UnityEngine.SceneManagement.SceneManager.LoadScene("Level_One");
end

function MainCityUIForm.ProcessMarket()
   
    print("执行到 ProcessMarket")  
    uiManager:ShowUIForms("MarketUIFrom")
end

function MainCityUIForm.ProcessEmallBtn()
   
    print("执行到 ProcessEmallBtn")  
    uiManager:ShowUIForms("NotificationUIForm")
end