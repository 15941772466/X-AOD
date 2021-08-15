
--炮塔实例行为管理
TurretManager={}
TurretManager.DefenseList = {}

function TurretManager.Start()

   for i,v in pairs(TurretManager.DefenseList) do
      v:Start()
   end
end

function TurretManager.Update()
   for i,v in pairs(TurretManager.DefenseList) do
      v:Update()
   end
end




