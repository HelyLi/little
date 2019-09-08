local System = {}

function System.getAppVersion()
    return "1.0.0"
end

--获取
function System.getVersionName()
    local ocParams = {}
    local javaParams = {}
    local javaMethodSig="()Ljava/lang/String;"

    local ret = NativeApi.callStaticMethod({
        className = "System",
        methodName = "getVersionName",
        ocParams = nil,
        javaParams = nil,
        javaMethodSig = javaMethodSig
    })
    return ret
end

function System.isLocationEnable()
    local ret = NativeApi.callStaticMethod({
        className = "System",
        methodName = "isLocationEnable",
        ocParams = nil,
        javaParams = nil,
        javaMethodSig = "()I"
    })

    print("System.isLocationEnable:", ret)

    return ret
end

function System.getLocation()
    local ocParams = {}
    local javaParams = {}
    local javaMethodSig="()Ljava/lang/String;"

    local ret = NativeApi.callStaticMethod({
        className = "System",
        methodName = "getLocation",
        ocParams = ocParams,
        javaParams = javaParams,
        javaMethodSig = javaMethodSig
    })
    local locatJson = json.decode(ret)
    return locatJson.latitude-locatJson.latitude%0.000001,locatJson.longitude-locatJson.longitude%0.000001
end

function System.getShareRoomInfo()
    local ocParames = {}
    local javaParams = {}
    local javaMethodSig="()Ljava/lang/String;"

    local ret = NativeApi.callStaticMethod({
        className = "System",
        methodName = "getShareRoomInfo",
        ocParames = nil,
        javaParams = nil,
        javaMethodSig = javaMethodSig
    })
    local retJson = json.decode(ret)
    dump(retJson)
    return retJson.gameId,retJson.roomId
end

function System.enterGPSSetting()
    local javaMethodSig="()V"
    NativeApi.callStaticMethod({
        className = "System",
        methodName = "enterGPSSetting",
        ocParames = nil,
        javaParams = nil,
        javaMethodSig = javaMethodSig
    })
end

function System.enterAppGPSSetting()
    local javaMethodSig="()V"
    NativeApi.callStaticMethod({
        className = "System",
        methodName = "enterAppGPSSetting",
        ocParames = nil,
        javaParams = nil,
        javaMethodSig = javaMethodSig
    })
end

function System.enterNetSetting()
    local javaMethodSig="()V"
    NativeApi.callStaticMethod({
        className = "System",
        methodName = "enterNetSetting",
        ocParames = nil,
        javaParams = nil,
        javaMethodSig = javaMethodSig
    })
end

function System.exitGame()
    local javaMethodSig="()V"
    NativeApi.callStaticMethod({
        className = "System",
        methodName = "exitGame",
        ocParames = nil,
        javaParams = nil,
        javaMethodSig = javaMethodSig
    })
end

function System.getPackageName()
    local javaMethodSig="()Ljava/lang/String;"
    local ret = NativeApi.callStaticMethod({
        className = "System",
        methodName = "getPackageName",
        ocParames = nil,
        javaParams = nil,
        javaMethodSig = javaMethodSig
    })
    dump(ret)
    return ret
end

function System.getAppName()
    local javaMethodSig="()Ljava/lang/String;"
    local ret = NativeApi.callStaticMethod({
        className = "System",
        methodName = "getAppName",
        ocParames = nil,
        javaParams = nil,
        javaMethodSig = javaMethodSig
    })
    dump(ret)
    return ret
end

-- 压缩图片质量
-- srcPath 源路径 dstPath 保存路径 quality 质量（0-1）
function System.compressImage( srcPath, dstPath, quality )
    quality = quality or 1.0
    
    local ocParames = {
        srcPath=srcPath,
        dstPath=dstPath,
        quality=quality
    }

    local javaParams = {
        srcPath,
        dstPath,
        quality
    }

    local javaMethodSig="(Ljava/lang/String;Ljava/lang/String;F)V"
    NativeApi.callStaticMethod({
        className = "System",
        methodName = "compressImage",
        ocParames = ocParames,
        javaParams = javaParams,
        javaMethodSig = javaMethodSig
    })
    return true
end

return System