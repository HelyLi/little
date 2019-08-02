#include "base/ccConfig.h"
#ifndef __system_utils_h__
#define __system_utils_h__

#ifdef __cplusplus
extern "C" {
#endif
#include "tolua++.h"
#ifdef __cplusplus
}
#endif

int register_all_SystemUtils_Tool(lua_State* tolua_S);

#endif