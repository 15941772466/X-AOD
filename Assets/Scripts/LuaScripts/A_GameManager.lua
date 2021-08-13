------虽然叫做GameManager，但是用来写计时器的


-- this=A_GameManager


-- function A_GameManager.Update()
--     local cor1 = coroutine.create(function()
-- 		WaitForSeconds(2);
-- 	end);
-- end
--设置延时循环函数 id,初次延时,循环后间隔延时,循环时间,循环函数,结束时回调函数
A_GameManager={
	tempTime = 0,
	
	--事件池
	TimerDict = {},
	timerIndex = 1
}
this=A_GameManager
function A_GameManager.GetInstance()
    return this
end


--class为之前写的面向对象类	
--TimeSystem = class()

--单例
-- TimeSystem.Instance = function()
-- 	if (TimeSystem.m_instance == nil) then
-- 		TimeSystem.m_instance = TimeSystem.new();
-- 	end
-- 	return TimeSystem.m_instance
-- end


--参数：时间间隔、循环几次、回调函数、回调对象、回调参数
function A_GameManager.AddTimer(delta,loopTimes,callBack,obj,param)
	if callBack==nil then
		return
	end
	
	this.TimerDict[this.timerIndex] = {leftTime = delta,delta = delta,loopTimes = loopTimes,callBack = callBack,obj = obj,param = param,timerIndex = this.timerIndex}
	this.timerIndex = this.timerIndex + 1;
	
	return this.timerIndex - 1
end

function A_GameManager.RemoveTimer(timerIndex)
	if timerIndex==nil then
		return
	end
	this.TimerDict[timerIndex] = nil
end

--让这个函数被Unity的Update每帧调用
--timeInterval：时间间隔
--每帧都调用函数，但不是每帧都遍历一次字典，不然太耗性能
--可以设置为0.1，一般延迟调用时间也不会太短
function A_GameManager.Update(timeInterval)
	
	this.tempTime = this.tempTime + CS.UnityEngine.Time.deltaTime;
	
	if this.tempTime < timeInterval then
		return
	else
		this.tempTime = 0
	end
	
	--遍历字典，更新剩余时间，时间到了就执行函数
	for k,v in pairs(this.TimerDict) do
		v.leftTime = v.leftTime - timeInterval
		
		if v.leftTime <= 0 then
			if v.obj ~= nil then
				if v.callBack then
					v.callBack(v.obj,v.param)
				end
			else
				if v.callBack then
					v.callBack(v.param)
				end
			end

			v.loopTimes = v.loopTimes - 1
			v.leftTime = v.delta
			
			if v.loopTimes <= 0 then
				v.callBack = nil
				this:RemoveTimer(v.timerIndex)
			end
		end
	end
end

function A_GameManager.Clear()
	this.TimerDict = {}
end
