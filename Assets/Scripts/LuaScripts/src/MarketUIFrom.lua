---
--- 防御塔窗口  UI窗体视图层脚本
---

MarketUIFrom = {}
local this = MarketUIFrom


local UI_Manager=CS.SUIFW.UIManager
local uiManager=UI_Manager.GetInstance()


local transform
local gameobject

--得到实例
function MarketUIFrom.GetInstance()
    return this
end

function MarketUIFrom.Awake(obj)
    print("------- MarketUIFrom.Awake  -----------")
    gameobject=obj
    transform=obj.transform
end

function MarketUIFrom.Start(obj)
    this.InitView()
end

function MarketUIFrom.InitView()
    --查找UI中按钮
    this.CloseBtn=transform:Find("Btn_Close")--返回transform
    this.CloseBtn=this.CloseBtn:GetComponent("UnityEngine.UI.Button") --返回Button类型
    this.CloseBtn.onClick:AddListener(this.ProcessBtn_Close)
end

function MarketUIFrom.ProcessBtn_Close()
   
    print("执行到 ProcessBtn_Close")  --开始游戏
    uiManager:CloseUIForms("MarketUIFrom")
end

