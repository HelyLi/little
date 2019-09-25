HttpCtrl = HttpCtrl or {}

function HttpCtrl.http(params)
    params = checktable(params)
    local method = params.method or "GET"
    local callback = params.callback
    local url = params.url

    if type(callback) ~= "function" then
        callback = function(...) end
    end

    local request = network.createHTTPRequest(function(event)
        if event.name == "completed" then
            local request = event.request
    
            local code = request:getResponseStatusCode()
            if code ~= 200 then
                -- 请求结束，但没有返回 200 响应代码
                callback({ code = code })
                return
            end
        
            -- 请求成功，显示服务端返回的内容
            local response = request:getResponseString()
            if string.find(response, "{") then
                response = checktable(json.decode(response))
            end
            callback({
                data = response,
                code = code
            })
        elseif event.name == "failed" then
            callback({
                code = request:getErrorCode(),
                message = request:getErrorMessage()
            })
        end
    end, url, string.upper(method))
    request:setTimeout(15)
    request:start()
end

--上传图片
function HttpCtrl.uploadImage(url,imageName,callback)
    local fullpath = cc.FileUtils:getInstance():fullPathForFilename(imageName)
    if fullpath == nil or string.len(fullpath) == 0 then
        print("uploadImage not find imageName = ",imageName)
        return
    end
    if type(callback) ~= "function" then
        callback = function ( ... ) end
    end
    local req = network.createHTTPRequest(function(event)
        local request = event.request
        if event.name == "completed" then
             --网络相关错误
            if (request:getResponseStatusCode() ~= 200 and request:getResponseStatusCode() ~= 304) then
                print(string.format("网络错误:http_code:%d,error_code:%d,msg:%s",
                request:getResponseStatusCode(),request:getErrorCode(),request:getErrorMessage()))
                callback({err= checknumber(request:getErrorCode()), msg=request:getErrorMessage()})
                return
            end
            local data = request:getResponseString()
            if string.find(data,"{") then
                data = checktable(json.decode(data))
            end
            callback({data = data,code = request:getResponseStatusCode()})
        elseif event.name == "progress"  then
        else
            callback({err= checknumber(request:getErrorCode()), msg=request:getErrorMessage()})
        end
    end,url,"POST")
    local data = io.readfile(fullpath)
    req:addRequestHeader("Content-Type: application/octet-stream")
    req:addRequestHeader("Agent: Texas/2.0")
    req:addRequestHeader("x-fl: "..string.len(data))
    req:addRequestHeader("x-lm: "..tostring(os.time()))
    req:setPOSTData(data)
    req:start()
end

return HttpCtrl