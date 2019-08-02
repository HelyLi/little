local Presenter = import("app.network.Presenter")
local HttpCtrl = import("app.network.http.HttpCtrl")
local UpdateEngine = import(".UpdateEngine")

local UpdatePresenter = class("UpdatePresenter",function()
    return Presenter.new()
end)

function UpdatePresenter:ctor(view)
    Presenter.init(self, view)
    HttpCtrl.http({url = "http://lyweb.wwg01.com/vinit/vinit?plat=2&proj=7&version=1.3.0&pkg=10001&clientid=0" , callback = handler(self, self.checkUpdateResponse)})
end

function UpdatePresenter:checkUpdateResponse(response)
    dump(response, "checkUpdateResponse")
    if response and response.data and response.data.lua_config then
        self.m_engine = UpdateEngine.new({
            dlpath = Game:getAppConfig():getMainResPath(),
            updateConfig = response.data.lua_config,
            callback = handler(self, self.notityCallback)
        })
    end
end

function UpdatePresenter:notifyCallBack(event)
    
end

function UpdatePresenter:startUpdate()
    if self.m_engine then
        self.m_engine:startUpdate()
    end
end

function UpdatePresenter:download()
    print("download")
    self.m_engine:test()
end

return UpdatePresenter