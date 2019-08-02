HttpCtrl = HttpCtrl or {}

function HttpCtrl.http(params)
    params = checktable(params)
    local method = params.method or "GET"
    local callback = params.callback
    local url = params.url

    if type(callback) ~= "function" then
        callback = function(data) end
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

return HttpCtrl