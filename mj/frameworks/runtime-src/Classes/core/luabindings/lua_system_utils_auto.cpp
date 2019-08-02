#include "lua_system_utils_auto.hpp"
#include <cocos2d.h>
#include <tolua++.h>
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"
#include "scripting/lua-bindings/manual/CCLuaEngine.h"
#include "scripting/lua-bindings/manual/cocos2d/LuaScriptHandlerMgr.h"
#include "base/ZipUtils.h"

static int tolua_system_unzip(lua_State* tolua_S)
{
    if (nullptr == tolua_S)
        return 0;
    
    int argc = 0;
    
    argc = lua_gettop(tolua_S) - 1;
    
    if (0== argc)
    {
        const char *path = tolua_tostring(tolua_S, 1, "");
        lua_pushboolean(tolua_S, ZipUtils::unCompressZip(path, ""));
        return 1;
    }
    
    CCLOG("'tolua_system_unzip' has wrong number of arguments: %d, was expecting %d\n", argc, 0);
    return 0;
}

TOLUA_API int register_all_SystemUtils_Tool(lua_State* tolua_S)
{
    tolua_open(tolua_S);
    
    tolua_module(tolua_S, "game", 0);
    tolua_beginmodule(tolua_S, "game");

    tolua_usertype(tolua_S, "system");
    tolua_cclass(tolua_S, "system", "system", "", nullptr);
    tolua_beginmodule(tolua_S, "system");
    tolua_function(tolua_S, "unZip", tolua_system_unzip);
    tolua_endmodule(tolua_S);
    
    std::string typeName = "system";
    g_luaType[typeName] = "system";
    g_typeCast["system"] = "system";
    tolua_endmodule(tolua_S);

    return 1;
}
