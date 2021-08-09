--防御塔A的加载

DefenseListUIForm={}
local this = DefenseListUIForm

--定义项目参数
local string dtName="DefenseA" 

--定义变量
local transform

-- --调用C#的ABFW框架上的DefenseManager
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()

--得到实例
function DefenseListUIForm.GetInstance()
    return this
end
--输入参数： obj 表示UI窗体对象。
function DefenseListUIForm.Awake(obj)
    print("------- DefenseListUIForm.Awake  -----------");
    transform=obj.transform
    --初始化面板，查找“开始按钮”
   this.InitView()

end

function DefenseListUIForm.InitView()
    print("------------------------------------------------------------------");
    --查找UI中按钮
    this.BtnA=transform:Find("DefenseA")--返回transform
    this.BtnA=this.BtnA:GetComponent("UnityEngine.UI.Button") --返回Button类型
    this.BtnA.onClick:AddListener(this.ProcessBtnA)
    -- print("aaa")
    -- this.BtnB=transform:Find("DefenseB")--返回transform
    -- this.BtnB=this.BtnB:GetComponent("UnityEngine.UI.Button") --返回Button类型

    -- this.BtnC=transform:Find("DefenseC")--返回transform
    -- this.BtnC=this.BtnC:GetComponent("UnityEngine.UI.Button") --返回Button类型

    --DefenseListUIForm.StartProcess()
end



--定义Button 的监听事件（回调方法）
function DefenseListUIForm.ProcessBtnA()
    --加载AB包
    print("执行到 TestDT_A_Ctr.StartProcess()，防御塔A正在加载中")
    local tmpObj=abDTObj:PrefabAB("DefenseA")
    local cloneObj=CS.UnityEngine.GameObject.Instantiate(tmpObj)
    print("执行到 TestDT_A_Ctr.StartProcess()，防御塔A加载完毕")
 end
--定义Button 的监听事件（回调方法）
function DefenseListUIForm.ProcessBtnB()
   --加载AB包
   print("防御塔B正在加载中")
   local tmpObj=abDTObj.PrefabAB("DefenseB")
   print(tmpObj)
   local cloneObj=CS.UnityEngine.Object.Instantiate(tmpObj)
   print("防御塔B加载完毕")
end

--定义Button 的监听事件（回调方法）
function DefenseListUIForm.ProcessBtnC()
    --加载AB包
    print("防御塔A正在加载中")
    local tmpObj=abDTObj.PrefabAB("DefenseC")
    print(tmpObj)
    local cloneObj=CS.UnityEngine.Object.Instantiate(tmpObj)
    print("防御塔C加载完毕")
 end