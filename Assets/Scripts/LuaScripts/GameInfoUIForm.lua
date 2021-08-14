---
--- 头像金币窗口  UI窗体视图层脚本
---

GameInfoUIForm = {}
local this = GameInfoUIForm

local UI_Manager=CS.UIFW.UIManager
local uiManager=UI_Manager.GetInstance()

local transform
local gameobject

--得到实例
function HeroInfoUIForm.GetInstance()
   return this
end

function GameInfoUIForm.Awake(obj)
   print("------- GameInfoUIForm.Awake  -----------");
   gameobject=obj
   transform=obj.transform
end

function GameInfoUIForm.Start(obj)
   coinsNumber=transform:Find("Coins/Text"):GetComponent("UnityEngine.UI.Text")
   
   this.InitView()
end

function GameInfoUIForm.InitView()
   --查找UI中按钮
   this.BackBtn=transform:Find("BackGameHall")
   this.BackBtn=this.BackBtn:GetComponent("UnityEngine.UI.Button") 
   this.BackBtn.onClick:AddListener(this.ProcessBackHallBtn)

end

function GameInfoUIForm.ProcessBackHallBtn()
  
   print("执行到 ProcessBackHallBtn")
   --打开窗体
   uiManager:ShowUIForms("MainCityUIForm")
   uiManager:ShowUIForms("HeroInfoUIForm")
   CS.UnityEngine.SceneManagement.SceneManager.LoadScene("Level_One");
end