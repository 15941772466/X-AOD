require  ("Observer")
-- 继承
ConcreteObserver = Observer:new()

-- 重写子类 run 方法
function ConcreteObserver:run()
    print(self.name.." do something")
end