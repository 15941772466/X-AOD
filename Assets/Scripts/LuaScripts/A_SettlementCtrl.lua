--游戏结算脚本

A_SettlementCtrl={}
this=A_SettlementCtrl


local UI_Manager=CS.UIFW.UIManager
local uiManager=UI_Manager.GetInstance()

function A_SettlementCtrl.GetInstance()
 	return this
end



--赢得战斗
function A_SettlementCtrl:Win()
  uiManager:ShowUIForms("VictoryUIForm")
  CSU.Time.timeScale=0
end
--战败
function A_SettlementCtrl:Failed()
  uiManager:ShowUIForms("DefeatUIForm")
  CSU.Time.timeScale=0
end 
--重玩
function A_SettlementCtrl:Retry()

end
--返回菜单
function A_SettlementCtrl:ButtonMenu()

end

