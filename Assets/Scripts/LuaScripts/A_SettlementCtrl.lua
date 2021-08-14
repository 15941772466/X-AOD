--游戏结算脚本

A_SettlementCtrl={}
this=A_SettlementCtrl


function A_SettlementCtrl.GetInstance()
 	return this
end



--赢得战斗
function A_SettlementCtrl.Win()
  print("赢得胜利")
end
--战败
function A_SettlementCtrl.Failed()

end
--重玩
function A_SettlementCtrl.Retry()

end
--返回菜单
function A_SettlementCtrl.ButtonMenu()

end

