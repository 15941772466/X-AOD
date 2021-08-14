Observer={}   --抽象基类

-- 名称
Observer.name=""

function Observer:new(_o)
   _o = _o  or {}
   setmetatable(_o,self)
   self.__index=self
   return _o
end

-- 动作
function Observer:do()
    print(self.name.."do something")
end
