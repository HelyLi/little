ComFunc = {}

function ComFunc.getIntegerForKey(key, default)
    return cc.UserDefault:getInstance():getIntegerForKey(key, default)
end

function ComFunc.setIntegerForKey(key, value)
    cc.UserDefault:getInstance():setIntegerForKey(key, value)
end

function ComFunc.getStringForKey(key, default)
    return cc.UserDefault:getInstance():getStringForKey(key, default)
end

function ComFunc.setStringForKey(key, value)
    cc.UserDefault:getInstance():setStringForKey(key, value)
end

function ComFunc.getBoolForKey(key, default)
    return cc.UserDefault:getInstance():getBoolForKey(key, default)
end

function ComFunc.setBoolForKey(key, value)
    cc.UserDefault:getInstance():setBoolForKey(key, value)
end

--统一的动态光晕
function ComFunc.setBlendFuncBase(node)
    if node ~= nil then
        node:setBlendFunc(gl.ONE, gl.ONE)
    end
end

-- -1 : ver1 < ver2
-- 0  : ver1 == ver2
-- 1  : ver1 > ver2

function ComFunc.compareVer(ver1,ver2)

    if ver2 == nil then return -1 end
    if ver1 == nil then return 1 end

    local vers1 = string.split(ver1,".")
    local vers2 = string.split(ver2,".")

    if vers2 == nil or vers2 == "" then
       return 1
    end

    for i = 1,#vers1 do
       local i1 = tonumber(vers1[i]) or 0
       local i2 = tonumber(vers2[i]) or 0
       if i1 > i2 then
         return 1
       end

       if i1 < i2 then
         return -1
       end
    end
    return 0
end

local ChineseNum = {
    [1] = "一",[2] = "二",[3] = "三",[4] = "四",[5] = "五",[6] = "六",[7]="七",[8]="八",[9]="九",[0] = "零"
}

-- 获取中文数字
function ComFunc.getChineseNum( num )
    return ChineseNum[num]
end


--统一处理错误码
function ComFunc.HandlingErrorCode(code)
    
end

return ComFunc
