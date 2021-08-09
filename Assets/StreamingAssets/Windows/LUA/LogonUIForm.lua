---
--- 登录窗口  UI窗体视图层脚本
---

LogonUIForm = {}
local this = LogonUIForm

-- 标题【welcome】
local logonTitle="[Welcome to Craty!]"

local transform
local gameobject
--说明:
--输入参数： obj 表示UI窗体对象。
function LogonUIForm.Awake(obj)
   gameobject=obj
   transform=obj.transform
end

function LogonUIForm.Start(obj)
    --查找与设置通知的标题 
    this.txtTitle=transform:Find("BG/TxtTitle"):GetComponent("UnityEngine.UI.Text")
    this.txtTitle.text=logonTitle
end
