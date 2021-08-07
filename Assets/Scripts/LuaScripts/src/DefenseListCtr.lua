--防御塔A的加载

DefenseListCtr={}
local this=DefenseListCtr


--调用C#的ABFW框架上的DefenseManager
local DTManager=CS.PFW.DefenseManager
local abDTObj=DTManager.GetInstance()

--得到实例
function DefenseListCtr.GetInstance()
    return this
end

--开始处理核心逻辑(开始处理)
function DefenseListCtr.StartProcess()
    
    local BtnA=DefenseListUIForm.BtnA
    --增加Button 的监听。
    BtnA.onClick:AddListener(this.ProcessBtnA)
    
    local BtnB=DefenseListUIForm.BtnB
    --增加Button 的监听。
    BtnB.onClick:AddListener(this.ProcessBtnB)
    
    local BtnC=DefenseListUIForm.BtnC
    --增加Button 的监听。
    BtnC.onClick:AddListener(this.ProcessBtnC)
    
end
 --定义Button 的监听事件（回调方法）
 function DefenseListCtr.ProcessBtnA()
    --加载AB包
    print("执行到 TestDT_A_Ctr.StartProcess()，防御塔A正在加载中")
    local tmpObj=abDTObj.PrefabAB("DefenseA")
    print(tmpObj)
    local cloneObj=CS.UnityEngine.Object.Instantiate(tmpObj)
    print("执行到 TestDT_A_Ctr.StartProcess()，防御塔A加载完毕")
 end
--定义Button 的监听事件（回调方法）
function DefenseListCtr.ProcessBtnB()
   --加载AB包
   print("防御塔B正在加载中")
   local tmpObj=abDTObj.PrefabAB("DefenseB")
   print(tmpObj)
   local cloneObj=CS.UnityEngine.Object.Instantiate(tmpObj)
   print("防御塔B加载完毕")
end

--定义Button 的监听事件（回调方法）
function DefenseListCtr.ProcessBtnC()
    --加载AB包
    print("防御塔A正在加载中")
    local tmpObj=abDTObj.PrefabAB("DefenseC")
    print(tmpObj)
    local cloneObj=CS.UnityEngine.Object.Instantiate(tmpObj)
    print("防御塔C加载完毕")
 end

