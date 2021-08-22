---
--- 背景故事 UI窗体视图层脚本
---
---
StoryUIForm = {}

local this = StoryUIForm

local UI_Manager=CS.UIFW.UIManager
local uiManager=UI_Manager.GetInstance()

local transform
local gameobject


-- 故事背景内容
local Content="\n<b>X博士：</b>\r\n　　故事发生在繁华的安布雷拉《保护元》公司的地下机械工程实验室——“蜂巢”里。\r\n\n　　数百名遗传学、机械工程学专家正在进行一项科学研究，一种机械重金属病毒突然爆发了并迅速传播着，病毒很快感染了所有的工作人。人类一旦感染这种并对，丧失意识，骨骼开始机械化，皮肤渐渐被金属腐蚀。\r\n\n　　一场疯狂的抗争机械病毒的战争由此爆发，面对着几乎无法控制的局面，几百个四处走动极具攻击性的机械人和更神秘的险恶力量，你作为救援小组的队员，怎样才能脱离困境并阻止病毒继续扩散呢？\r\n\n　　　　　　　　　　　　　　X-AOD世纪 3021年8月25日"


--得到实例
function StoryUIForm.GetInstance()
   return this
end

--说明:
--输入参数： obj 表示UI窗体对象。
function StoryUIForm.Awake(obj)
    print("------- StoryUIForm.Awake  -----------");
    gameobject=obj
    transform=obj.transform
end

function StoryUIForm.Start(obj)
   --查找与设置通知的标题 
    this.txtContent=transform:Find("ScrollView/Content/Text"):GetComponent("UnityEngine.UI.Text")
    this.txtContent.text=Content
    this.InitView()
end

function StoryUIForm.InitView()
    print("------------------------------------------------------------------");
    --查找UI中按钮
    this.ContinueBtn=transform:Find("BtnConfirm")--返回transform
    this.ContinueBtn=this.ContinueBtn:GetComponent("UnityEngine.UI.Button") --返回Button类型
    this.ContinueBtn.onClick:AddListener(this.ProcessContinueBtn)

end

function StoryUIForm.ProcessContinueBtn()
    --加载AB包
    print("执行到 ProcessContinueBtn")
    --打开窗体
    uiManager:ShowUIForms("MainCityUIForm")
    uiManager:ShowUIForms("HeroInfoUIForm")
 end
