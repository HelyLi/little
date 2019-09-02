NativeApi = {}

--params
--[[
    className = ""
    methodName = ""
    ocParames = {}
    javaParams = {}
    javaMethodSig = ""
]]

function NativeApi.callStaticMethod(params)
    local JAVA_CLASS_PREFIX = "org.cocos2dx.platform."
    local ok,ret=false,nil
    if device.platform == "ios" then
        local luaoc = require(cc.PACKAGE_NAME .. ".platform.luaoc")
        ok,ret=luaoc.callStaticMethod(params.className,params.methodName,params.ocParams)
    elseif device.platform == "android" then
        local luaj = require(cc.PACKAGE_NAME .. ".platform.luaj")
        params.className = JAVA_CLASS_PREFIX..params.className
        ok,ret=luaj.callStaticMethod(params.className,params.methodName,params.javaParams,params.javaMethodSig)
    end

    if ok == false then
        print("call "..params.className.."["..params.methodName.."] error!")
    else
        return ret
    end
end

return NativeApi