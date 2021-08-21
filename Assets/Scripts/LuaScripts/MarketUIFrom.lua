---
--- 防御塔窗口  UI窗体视图层脚本
---

MarketUIFrom = {}
local this = MarketUIFrom


local UI_Manager=CS.UIFW.UIManager
local uiManager=UI_Manager.GetInstance()


local transform
local gameobject

local baseuiform
--得到实例
function MarketUIFrom.GetInstance()
    return this
end

function MarketUIFrom.Awake(obj)
    print("------- MarketUIFrom.Awake  -----------")
    gameobject=obj
    transform=obj.transform
    baseuiform=gameobject:GetComponent("BaseUIForm")
end

function MarketUIFrom.Start(obj)
    this.InitView()
end

function MarketUIFrom.InitView()
    --关闭
    this.CloseBtn=transform:Find("Btn_Close"):GetComponent("UnityEngine.UI.Button") 
    this.CloseBtn.onClick:AddListener(this.ProcessBtn_Close)
    --防御塔A
    this.DefenseA=transform:Find("DefenseA"):GetComponent("UnityEngine.UI.Button") 
    this.DefenseA.onClick:AddListener(this.ProcessBtn_DefenseA)
    --防御塔B
    this.DefenseB=transform:Find("DefenseB"):GetComponent("UnityEngine.UI.Button") 
    this.DefenseB.onClick:AddListener(this.ProcessBtn_DefenseB)
    --防御塔C
    this.DefenseC=transform:Find("DefenseC"):GetComponent("UnityEngine.UI.Button")
    this.DefenseC.onClick:AddListener(this.ProcessBtn_DefenseC)
end

function MarketUIFrom.ProcessBtn_Close()
    print("执行到 ProcessBtn_Close") 
    uiManager:CloseUIForms("MarketUIFrom")
end

--给防御塔列表按钮绑定点击事件
function MarketUIFrom.ProcessBtn_DefenseA()
    print("点击了Ticket")
    uiManager:ShowUIForms("PropDetailUIForm")
    local strArray ="详细介绍：\n\n<b>X-aod</b>\r\n\n　　攻击速度较慢(CD为1秒),伤害为50,射程为2格，价格：150。 \r\n\n　　职业选手推荐指数：5 \r\n\n　　每次攻击都只作用于单体，这种攻击类型非常克制高血量的单位，该塔是高效的伤害输出塔。" 
    baseuiform:SendMessage("Detail",strArray)
end

function MarketUIFrom.ProcessBtn_DefenseB()
    uiManager:ShowUIForms("PropDetailUIForm")
    local strArray ="详细介绍：\n\n<b>加特林重机枪</b>\r\n\n　　攻击速度较快(CD为0.3秒),伤害为40,射程为4格，价格；400。 \r\n\n　　职业选手推荐指数：4 \r\n\n　　加特林以高射速低伤害扫向敌军，但并不是所有子弹都可以找到自己的宿主，机枪杀脆皮的目标是很猛的。" 
    baseuiform:SendMessage("Detail", strArray)
end

function MarketUIFrom.ProcessBtn_DefenseC()
    uiManager:ShowUIForms("PropDetailUIForm")
    local strArray ="详细介绍：\n\n<b>激光喷射器</b>\r\n\n　　持续攻击5秒(CD为3秒),伤害为30，射程为3格，价格：300。 \r\n\n　　职业选手推荐指数：8 \r\n\n　　尽管有着无坚不摧的火力，但激光塔受到了一个重大弱点的困扰——不会将敌人赶尽杀绝。" 
    baseuiform:SendMessage("Detail", strArray)
end

