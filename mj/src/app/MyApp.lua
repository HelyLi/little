
require("config")
require("cocos.init")
require("framework.init")

if ENABLE_PRINT == false then
	function dump( ... )
	end

	function print( ... )
	end
end

local searchPaths = cc.FileUtils:getInstance():getSearchPaths()
local writablePath = cc.FileUtils:getInstance():getWritablePath()
local storagePath_ = writablePath.."new_version"
local mainStoragePath_ = writablePath.."main_version"
local addPaths = {
	storagePath_,
	storagePath_.."/res/",
	storagePath_.."/res/750x1334",
	mainStoragePath_,
	mainStoragePath_.."/res/",
	mainStoragePath_.."/res/750x1334",
	"res/",
	"res/750x1334/",
	writablePath.."user",
	writablePath.."cross_user",
}

local AppBase = require("framework.AppBase")
local MyApp = class("MyApp", AppBase)

function MyApp:ctor()
    MyApp.super.ctor(self)
end

function MyApp:run()
	cc.FileUtils:getInstance():setSearchPaths(addPaths)
	print("== listing engine search path")
	local searchPaths = cc.FileUtils:getInstance():getSearchPaths()
	for k,v in pairs(searchPaths) do
		print(k,v)
	end
    display.replaceScene(require("app.scenes.update.UpdateScene").new())
end

return MyApp
